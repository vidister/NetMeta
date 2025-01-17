package main

import (
	"context"
	"flag"
	"net"
	"os"
	"os/signal"
	"sync"
	"time"

	"github.com/sirupsen/logrus"

	"github.com/cloudflare/goflow/v3/transport"
)

var (
	interfaces           string
	sampleRate           int
	logLevel             string
	fixedLength          bool
	workerCount          int
	fanoutBase           int
	samplerAddressString string
	samplerAddress       net.IP
)

func init() {
	flag.StringVar(&interfaces, "iface", "", "which interface to use in the following format: RX_NAME:TX_NAME,RX_NAME:TX_NAME")
	flag.IntVar(&sampleRate, "samplerate", 1000, "the samplerate to use")
	flag.StringVar(&logLevel, "loglevel", "info", "Log level")
	flag.BoolVar(&fixedLength, "proto.fixedlen", false, "Enable fixed length protobuf")
	flag.IntVar(&workerCount, "workercount", 8, "Number of workers per interface")
	flag.IntVar(&fanoutBase, "fanoutBase", 42, "fanout group base id")
	flag.StringVar(&samplerAddressString, "sampler-address", "127.0.0.1", "The address the instance use as SamplerAddress")
}

func main() {
	transport.RegisterFlags()
	flag.Parse()

	lvl, _ := logrus.ParseLevel(logLevel)
	logrus.SetLevel(lvl)

	samplerAddress = net.ParseIP(samplerAddressString)
	if samplerAddress == nil {
		logrus.Fatalf("invalid sampler-address provided: %q", samplerAddressString)
	}

	tapPairs := loadConfig()

	kafkaState, err := transport.StartKafkaProducerFromArgs(logrus.StandardLogger())
	if err != nil {
		logrus.Fatal(err)
	}
	kafkaState.FixedLengthProto = fixedLength

	var startGroup, endGroup sync.WaitGroup
	startGroup.Add(workerCount * len(tapPairs) * 2)
	endGroup.Add(workerCount * len(tapPairs) * 2)

	ctx, cancelFunc := context.WithCancel(context.Background())
	for _, tp := range tapPairs {
		logrus.Infof("Starting workers on pair: RX: %q - TX: %q", tp.RX.name, tp.TX.name)
		for i := 0; i < workerCount; i++ {
			go tp.TX.Worker(ctx, &startGroup, &endGroup, kafkaState)
		}

		for i := 0; i < workerCount; i++ {
			go tp.RX.Worker(ctx, &startGroup, &endGroup, kafkaState)
		}
	}
	logrus.Infof("Waiting for workers to become ready...")
	startGroup.Wait()
	logrus.Infof("Lets go!")

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt)

	<-c
	logrus.Println("Got Interrupt. Exiting...")
	cancelFunc()

	logrus.Println("Waiting a maxiumum of 10 Seconds for goroutines to shutdown")
	timeout, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	go func() {
		endGroup.Wait()
		cancel()
	}()

	defer cancel()
	<-timeout.Done()
}
