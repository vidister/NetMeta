package k8s

k8s: crds: "kafkas.kafka.strimzi.io": spec: {
	group: "kafka.strimzi.io"
	versions: [{
		name:    "v1beta1"
		served:  true
		storage: true
	}, {
		name:    "v1alpha1"
		served:  true
		storage: false
	}]
	version: "v1beta1"
	scope:   "Namespaced"
	names: {
		kind:     "Kafka"
		listKind: "KafkaList"
		singular: "kafka"
		plural:   "kafkas"
		shortNames: [
			"k",
		]
		categories: [
			"strimzi",
		]
	}
	additionalPrinterColumns: [{
		name:        "Desired Kafka replicas"
		description: "The desired number of Kafka replicas in the cluster"
		JSONPath:    ".spec.kafka.replicas"
		type:        "integer"
	}, {
		name:        "Desired ZK replicas"
		description: "The desired number of ZooKeeper replicas in the cluster"
		JSONPath:    ".spec.zookeeper.replicas"
		type:        "integer"
	}]
	subresources: status: {}
	validation: openAPIV3Schema: properties: {
		spec: {
			type: "object"
			properties: {
				kafka: {
					type: "object"
					properties: {
						replicas: {
							type:    "integer"
							minimum: 1
						}
						image: type: "string"
						storage: {
							type: "object"
							properties: {
								class: type:       "string"
								deleteClaim: type: "boolean"
								id: {
									type:    "integer"
									minimum: 0
								}
								overrides: {
									type: "array"
									items: {
										type: "object"
										properties: {
											class: type:  "string"
											broker: type: "integer"
										}
									}
								}
								selector: type: "object"
								size: type:     "string"
								sizeLimit: {
									type:    "string"
									pattern: "^([0-9.]+)([eEinumkKMGTP]*[-+]?[0-9]*)$"
								}
								type: {
									type: "string"
									enum: [
										"ephemeral",
										"persistent-claim",
										"jbod",
									]
								}
								volumes: {
									type: "array"
									items: {
										type: "object"
										properties: {
											class: type:       "string"
											deleteClaim: type: "boolean"
											id: {
												type:    "integer"
												minimum: 0
											}
											overrides: {
												type: "array"
												items: {
													type: "object"
													properties: {
														class: type:  "string"
														broker: type: "integer"
													}
												}
											}
											selector: type: "object"
											size: type:     "string"
											sizeLimit: {
												type:    "string"
												pattern: "^([0-9.]+)([eEinumkKMGTP]*[-+]?[0-9]*)$"
											}
											type: {
												type: "string"
												enum: [
													"ephemeral",
													"persistent-claim",
												]
											}
										}
										required: [
											"type",
										]
									}
								}
							}
							required: [
								"type",
							]
						}
						listeners: {
							type: "object"
							properties: {
								plain: {
									type: "object"
									properties: {
										authentication: {
											type: "object"
											properties: {
												accessTokenIsJwt: type:     "boolean"
												checkAccessTokenType: type: "boolean"
												clientId: type:             "string"
												clientSecret: {
													type: "object"
													properties: {
														key: type:        "string"
														secretName: type: "string"
													}
													required: [
														"key",
														"secretName",
													]
												}
												disableTlsHostnameVerification: type: "boolean"
												enableECDSA: type:                    "boolean"
												introspectionEndpointUri: type:       "string"
												jwksEndpointUri: type:                "string"
												jwksExpirySeconds: {
													type:    "integer"
													minimum: 1
												}
												jwksRefreshSeconds: {
													type:    "integer"
													minimum: 1
												}
												tlsTrustedCertificates: {
													type: "array"
													items: {
														type: "object"
														properties: {
															certificate: type: "string"
															secretName: type:  "string"
														}
														required: [
															"certificate",
															"secretName",
														]
													}
												}
												type: {
													type: "string"
													enum: [
														"tls",
														"scram-sha-512",
														"oauth",
													]
												}
												userNameClaim: type:  "string"
												validIssuerUri: type: "string"
											}
											required: [
												"type",
											]
										}
										networkPolicyPeers: {
											type: "array"
											items: {
												type: "object"
												properties: {
													ipBlock: {
														type: "object"
														properties: {
															cidr: type: "string"
															except: {
																type: "array"
																items: type: "string"
															}
														}
													}
													namespaceSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													podSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
												}
											}
										}
									}
								}
								tls: {
									type: "object"
									properties: {
										authentication: {
											type: "object"
											properties: {
												accessTokenIsJwt: type:     "boolean"
												checkAccessTokenType: type: "boolean"
												clientId: type:             "string"
												clientSecret: {
													type: "object"
													properties: {
														key: type:        "string"
														secretName: type: "string"
													}
													required: [
														"key",
														"secretName",
													]
												}
												disableTlsHostnameVerification: type: "boolean"
												enableECDSA: type:                    "boolean"
												introspectionEndpointUri: type:       "string"
												jwksEndpointUri: type:                "string"
												jwksExpirySeconds: {
													type:    "integer"
													minimum: 1
												}
												jwksRefreshSeconds: {
													type:    "integer"
													minimum: 1
												}
												tlsTrustedCertificates: {
													type: "array"
													items: {
														type: "object"
														properties: {
															certificate: type: "string"
															secretName: type:  "string"
														}
														required: [
															"certificate",
															"secretName",
														]
													}
												}
												type: {
													type: "string"
													enum: [
														"tls",
														"scram-sha-512",
														"oauth",
													]
												}
												userNameClaim: type:  "string"
												validIssuerUri: type: "string"
											}
											required: [
												"type",
											]
										}
										configuration: {
											type: "object"
											properties: brokerCertChainAndKey: {
												type: "object"
												properties: {
													certificate: type: "string"
													key: type:         "string"
													secretName: type:  "string"
												}
												required: [
													"certificate",
													"key",
													"secretName",
												]
											}
										}
										networkPolicyPeers: {
											type: "array"
											items: {
												type: "object"
												properties: {
													ipBlock: {
														type: "object"
														properties: {
															cidr: type: "string"
															except: {
																type: "array"
																items: type: "string"
															}
														}
													}
													namespaceSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													podSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
												}
											}
										}
									}
								}
								external: {
									type: "object"
									properties: {
										authentication: {
											type: "object"
											properties: {
												accessTokenIsJwt: type:     "boolean"
												checkAccessTokenType: type: "boolean"
												clientId: type:             "string"
												clientSecret: {
													type: "object"
													properties: {
														key: type:        "string"
														secretName: type: "string"
													}
													required: [
														"key",
														"secretName",
													]
												}
												disableTlsHostnameVerification: type: "boolean"
												enableECDSA: type:                    "boolean"
												introspectionEndpointUri: type:       "string"
												jwksEndpointUri: type:                "string"
												jwksExpirySeconds: {
													type:    "integer"
													minimum: 1
												}
												jwksRefreshSeconds: {
													type:    "integer"
													minimum: 1
												}
												tlsTrustedCertificates: {
													type: "array"
													items: {
														type: "object"
														properties: {
															certificate: type: "string"
															secretName: type:  "string"
														}
														required: [
															"certificate",
															"secretName",
														]
													}
												}
												type: {
													type: "string"
													enum: [
														"tls",
														"scram-sha-512",
														"oauth",
													]
												}
												userNameClaim: type:  "string"
												validIssuerUri: type: "string"
											}
											required: [
												"type",
											]
										}
										class: type: "string"
										configuration: {
											type: "object"
											properties: {
												bootstrap: {
													type: "object"
													properties: {
														address: type:        "string"
														dnsAnnotations: type: "object"
														host: type:           "string"
													}
													required: [
														"host",
													]
												}
												brokers: {
													type: "array"
													items: {
														type: "object"
														properties: {
															broker: type:         "integer"
															advertisedHost: type: "string"
															advertisedPort: type: "integer"
															host: type:           "string"
															dnsAnnotations: type: "object"
														}
														required: [
															"host",
														]
													}
												}
												brokerCertChainAndKey: {
													type: "object"
													properties: {
														certificate: type: "string"
														key: type:         "string"
														secretName: type:  "string"
													}
													required: [
														"certificate",
														"key",
														"secretName",
													]
												}
											}
										}
										networkPolicyPeers: {
											type: "array"
											items: {
												type: "object"
												properties: {
													ipBlock: {
														type: "object"
														properties: {
															cidr: type: "string"
															except: {
																type: "array"
																items: type: "string"
															}
														}
													}
													namespaceSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													podSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
												}
											}
										}
										overrides: {
											type: "object"
											properties: {
												bootstrap: {
													type: "object"
													properties: {
														address: type:        "string"
														dnsAnnotations: type: "object"
														nodePort: type:       "integer"
													}
												}
												brokers: {
													type: "array"
													items: {
														type: "object"
														properties: {
															broker: type:         "integer"
															advertisedHost: type: "string"
															advertisedPort: type: "integer"
															nodePort: type:       "integer"
															dnsAnnotations: type: "object"
														}
													}
												}
											}
										}
										tls: type: "boolean"
										type: {
											type: "string"
											enum: [
												"route",
												"loadbalancer",
												"nodeport",
												"ingress",
											]
										}
									}
									required: [
										"type",
									]
								}
							}
						}
						authorization: {
							type: "object"
							properties: {
								clientId: type:                       "string"
								delegateToKafkaAcls: type:            "boolean"
								disableTlsHostnameVerification: type: "boolean"
								superUsers: {
									type: "array"
									items: type: "string"
								}
								tlsTrustedCertificates: {
									type: "array"
									items: {
										type: "object"
										properties: {
											certificate: type: "string"
											secretName: type:  "string"
										}
										required: [
											"certificate",
											"secretName",
										]
									}
								}
								tokenEndpointUri: type: "string"
								type: {
									type: "string"
									enum: [
										"simple",
										"keycloak",
									]
								}
							}
							required: [
								"type",
							]
						}
						config: type: "object"
						rack: {
							type: "object"
							properties: topologyKey: {
								type:    "string"
								example: "failure-domain.beta.kubernetes.io/zone"
							}
							required: [
								"topologyKey",
							]
						}
						brokerRackInitImage: type: "string"
						affinity: {
							type: "object"
							properties: {
								nodeAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													preference: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchFields: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "object"
											properties: nodeSelectorTerms: {
												type: "array"
												items: {
													type: "object"
													properties: {
														matchExpressions: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	key: type:      "string"
																	operator: type: "string"
																	values: {
																		type: "array"
																		items: type: "string"
																	}
																}
															}
														}
														matchFields: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	key: type:      "string"
																	operator: type: "string"
																	values: {
																		type: "array"
																		items: type: "string"
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
								podAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													podAffinityTerm: {
														type: "object"
														properties: {
															labelSelector: {
																type: "object"
																properties: {
																	matchExpressions: {
																		type: "array"
																		items: {
																			type: "object"
																			properties: {
																				key: type:      "string"
																				operator: type: "string"
																				values: {
																					type: "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																	matchLabels: type: "object"
																}
															}
															namespaces: {
																type: "array"
																items: type: "string"
															}
															topologyKey: type: "string"
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													labelSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													namespaces: {
														type: "array"
														items: type: "string"
													}
													topologyKey: type: "string"
												}
											}
										}
									}
								}
								podAntiAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													podAffinityTerm: {
														type: "object"
														properties: {
															labelSelector: {
																type: "object"
																properties: {
																	matchExpressions: {
																		type: "array"
																		items: {
																			type: "object"
																			properties: {
																				key: type:      "string"
																				operator: type: "string"
																				values: {
																					type: "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																	matchLabels: type: "object"
																}
															}
															namespaces: {
																type: "array"
																items: type: "string"
															}
															topologyKey: type: "string"
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													labelSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													namespaces: {
														type: "array"
														items: type: "string"
													}
													topologyKey: type: "string"
												}
											}
										}
									}
								}
							}
						}
						tolerations: {
							type: "array"
							items: {
								type: "object"
								properties: {
									effect: type:            "string"
									key: type:               "string"
									operator: type:          "string"
									tolerationSeconds: type: "integer"
									value: type:             "string"
								}
							}
						}
						livenessProbe: {
							type: "object"
							properties: {
								failureThreshold: type: "integer"
								initialDelaySeconds: {
									type:    "integer"
									minimum: 0
								}
								periodSeconds: type:    "integer"
								successThreshold: type: "integer"
								timeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
							}
						}
						readinessProbe: {
							type: "object"
							properties: {
								failureThreshold: type: "integer"
								initialDelaySeconds: {
									type:    "integer"
									minimum: 0
								}
								periodSeconds: type:    "integer"
								successThreshold: type: "integer"
								timeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
							}
						}
						jvmOptions: {
							type: "object"
							properties: {
								"-XX": type: "object"
								"-Xms": {
									type:    "string"
									pattern: "[0-9]+[mMgG]?"
								}
								"-Xmx": {
									type:    "string"
									pattern: "[0-9]+[mMgG]?"
								}
								gcLoggingEnabled: type: "boolean"
								javaSystemProperties: {
									type: "array"
									items: {
										type: "object"
										properties: {
											name: type:  "string"
											value: type: "string"
										}
									}
								}
							}
						}
						jmxOptions: {
							type: "object"
							properties: authentication: {
								type: "object"
								properties: type: {
									type: "string"
									enum: [
										"password",
									]
								}
								required: [
									"type",
								]
							}
						}
						resources: {
							type: "object"
							properties: {
								limits: type:   "object"
								requests: type: "object"
							}
						}
						metrics: type: "object"
						logging: {
							type: "object"
							properties: {
								loggers: type: "object"
								name: type:    "string"
								type: {
									type: "string"
									enum: [
										"inline",
										"external",
									]
								}
							}
							required: [
								"type",
							]
						}
						tlsSidecar: {
							type: "object"
							properties: {
								image: type: "string"
								livenessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								logLevel: {
									type: "string"
									enum: [
										"emerg",
										"alert",
										"crit",
										"err",
										"warning",
										"notice",
										"info",
										"debug",
									]
								}
								readinessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								resources: {
									type: "object"
									properties: {
										limits: type:   "object"
										requests: type: "object"
									}
								}
							}
						}
						template: {
							type: "object"
							properties: {
								statefulset: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								pod: {
									type: "object"
									properties: {
										metadata: {
											type: "object"
											properties: {
												labels: type:      "object"
												annotations: type: "object"
											}
										}
										imagePullSecrets: {
											type: "array"
											items: {
												type: "object"
												properties: name: type: "string"
											}
										}
										securityContext: {
											type: "object"
											properties: {
												fsGroup: type:      "integer"
												runAsGroup: type:   "integer"
												runAsNonRoot: type: "boolean"
												runAsUser: type:    "integer"
												seLinuxOptions: {
													type: "object"
													properties: {
														level: type: "string"
														role: type:  "string"
														type: type:  "string"
														user: type:  "string"
													}
												}
												supplementalGroups: {
													type: "array"
													items: type: "integer"
												}
												sysctls: {
													type: "array"
													items: {
														type: "object"
														properties: {
															name: type:  "string"
															value: type: "string"
														}
													}
												}
												windowsOptions: {
													type: "object"
													properties: {
														gmsaCredentialSpec: type:     "string"
														gmsaCredentialSpecName: type: "string"
													}
												}
											}
										}
										terminationGracePeriodSeconds: {
											type:    "integer"
											minimum: 0
										}
										affinity: {
											type: "object"
											properties: {
												nodeAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	preference: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchFields: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "object"
															properties: nodeSelectorTerms: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		matchExpressions: {
																			type: "array"
																			items: {
																				type: "object"
																				properties: {
																					key: type:      "string"
																					operator: type: "string"
																					values: {
																						type: "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchFields: {
																			type: "array"
																			items: {
																				type: "object"
																				properties: {
																					key: type:      "string"
																					operator: type: "string"
																					values: {
																						type: "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
												podAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	podAffinityTerm: {
																		type: "object"
																		properties: {
																			labelSelector: {
																				type: "object"
																				properties: {
																					matchExpressions: {
																						type: "array"
																						items: {
																							type: "object"
																							properties: {
																								key: type:      "string"
																								operator: type: "string"
																								values: {
																									type: "array"
																									items: type: "string"
																								}
																							}
																						}
																					}
																					matchLabels: type: "object"
																				}
																			}
																			namespaces: {
																				type: "array"
																				items: type: "string"
																			}
																			topologyKey: type: "string"
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	labelSelector: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchLabels: type: "object"
																		}
																	}
																	namespaces: {
																		type: "array"
																		items: type: "string"
																	}
																	topologyKey: type: "string"
																}
															}
														}
													}
												}
												podAntiAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	podAffinityTerm: {
																		type: "object"
																		properties: {
																			labelSelector: {
																				type: "object"
																				properties: {
																					matchExpressions: {
																						type: "array"
																						items: {
																							type: "object"
																							properties: {
																								key: type:      "string"
																								operator: type: "string"
																								values: {
																									type: "array"
																									items: type: "string"
																								}
																							}
																						}
																					}
																					matchLabels: type: "object"
																				}
																			}
																			namespaces: {
																				type: "array"
																				items: type: "string"
																			}
																			topologyKey: type: "string"
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	labelSelector: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchLabels: type: "object"
																		}
																	}
																	namespaces: {
																		type: "array"
																		items: type: "string"
																	}
																	topologyKey: type: "string"
																}
															}
														}
													}
												}
											}
										}
										priorityClassName: type: "string"
										schedulerName: type:     "string"
										tolerations: {
											type: "array"
											items: {
												type: "object"
												properties: {
													effect: type:            "string"
													key: type:               "string"
													operator: type:          "string"
													tolerationSeconds: type: "integer"
													value: type:             "string"
												}
											}
										}
									}
								}
								bootstrapService: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								brokersService: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								externalBootstrapService: {
									type: "object"
									properties: {
										metadata: {
											type: "object"
											properties: {
												labels: type:      "object"
												annotations: type: "object"
											}
										}
										externalTrafficPolicy: {
											type: "string"
											enum: [
												"Local",
												"Cluster",
											]
										}
										loadBalancerSourceRanges: {
											type: "array"
											items: type: "string"
										}
									}
								}
								perPodService: {
									type: "object"
									properties: {
										metadata: {
											type: "object"
											properties: {
												labels: type:      "object"
												annotations: type: "object"
											}
										}
										externalTrafficPolicy: {
											type: "string"
											enum: [
												"Local",
												"Cluster",
											]
										}
										loadBalancerSourceRanges: {
											type: "array"
											items: type: "string"
										}
									}
								}
								externalBootstrapRoute: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								perPodRoute: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								externalBootstrapIngress: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								perPodIngress: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								persistentVolumeClaim: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								podDisruptionBudget: {
									type: "object"
									properties: {
										metadata: {
											type: "object"
											properties: {
												labels: type:      "object"
												annotations: type: "object"
											}
										}
										maxUnavailable: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								kafkaContainer: {
									type: "object"
									properties: env: {
										type: "array"
										items: {
											type: "object"
											properties: {
												name: type:  "string"
												value: type: "string"
											}
										}
									}
								}
								tlsSidecarContainer: {
									type: "object"
									properties: env: {
										type: "array"
										items: {
											type: "object"
											properties: {
												name: type:  "string"
												value: type: "string"
											}
										}
									}
								}
								initContainer: {
									type: "object"
									properties: env: {
										type: "array"
										items: {
											type: "object"
											properties: {
												name: type:  "string"
												value: type: "string"
											}
										}
									}
								}
							}
						}
						version: type: "string"
					}
					required: [
						"replicas",
						"storage",
						"listeners",
					]
				}
				zookeeper: {
					type: "object"
					properties: {
						replicas: {
							type:    "integer"
							minimum: 1
						}
						image: type: "string"
						storage: {
							type: "object"
							properties: {
								class: type:       "string"
								deleteClaim: type: "boolean"
								id: {
									type:    "integer"
									minimum: 0
								}
								overrides: {
									type: "array"
									items: {
										type: "object"
										properties: {
											class: type:  "string"
											broker: type: "integer"
										}
									}
								}
								selector: type: "object"
								size: type:     "string"
								sizeLimit: {
									type:    "string"
									pattern: "^([0-9.]+)([eEinumkKMGTP]*[-+]?[0-9]*)$"
								}
								type: {
									type: "string"
									enum: [
										"ephemeral",
										"persistent-claim",
									]
								}
							}
							required: [
								"type",
							]
						}
						config: type: "object"
						affinity: {
							type: "object"
							properties: {
								nodeAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													preference: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchFields: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "object"
											properties: nodeSelectorTerms: {
												type: "array"
												items: {
													type: "object"
													properties: {
														matchExpressions: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	key: type:      "string"
																	operator: type: "string"
																	values: {
																		type: "array"
																		items: type: "string"
																	}
																}
															}
														}
														matchFields: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	key: type:      "string"
																	operator: type: "string"
																	values: {
																		type: "array"
																		items: type: "string"
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
								podAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													podAffinityTerm: {
														type: "object"
														properties: {
															labelSelector: {
																type: "object"
																properties: {
																	matchExpressions: {
																		type: "array"
																		items: {
																			type: "object"
																			properties: {
																				key: type:      "string"
																				operator: type: "string"
																				values: {
																					type: "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																	matchLabels: type: "object"
																}
															}
															namespaces: {
																type: "array"
																items: type: "string"
															}
															topologyKey: type: "string"
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													labelSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													namespaces: {
														type: "array"
														items: type: "string"
													}
													topologyKey: type: "string"
												}
											}
										}
									}
								}
								podAntiAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													podAffinityTerm: {
														type: "object"
														properties: {
															labelSelector: {
																type: "object"
																properties: {
																	matchExpressions: {
																		type: "array"
																		items: {
																			type: "object"
																			properties: {
																				key: type:      "string"
																				operator: type: "string"
																				values: {
																					type: "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																	matchLabels: type: "object"
																}
															}
															namespaces: {
																type: "array"
																items: type: "string"
															}
															topologyKey: type: "string"
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													labelSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													namespaces: {
														type: "array"
														items: type: "string"
													}
													topologyKey: type: "string"
												}
											}
										}
									}
								}
							}
						}
						tolerations: {
							type: "array"
							items: {
								type: "object"
								properties: {
									effect: type:            "string"
									key: type:               "string"
									operator: type:          "string"
									tolerationSeconds: type: "integer"
									value: type:             "string"
								}
							}
						}
						livenessProbe: {
							type: "object"
							properties: {
								failureThreshold: type: "integer"
								initialDelaySeconds: {
									type:    "integer"
									minimum: 0
								}
								periodSeconds: type:    "integer"
								successThreshold: type: "integer"
								timeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
							}
						}
						readinessProbe: {
							type: "object"
							properties: {
								failureThreshold: type: "integer"
								initialDelaySeconds: {
									type:    "integer"
									minimum: 0
								}
								periodSeconds: type:    "integer"
								successThreshold: type: "integer"
								timeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
							}
						}
						jvmOptions: {
							type: "object"
							properties: {
								"-XX": type: "object"
								"-Xms": {
									type:    "string"
									pattern: "[0-9]+[mMgG]?"
								}
								"-Xmx": {
									type:    "string"
									pattern: "[0-9]+[mMgG]?"
								}
								gcLoggingEnabled: type: "boolean"
								javaSystemProperties: {
									type: "array"
									items: {
										type: "object"
										properties: {
											name: type:  "string"
											value: type: "string"
										}
									}
								}
							}
						}
						resources: {
							type: "object"
							properties: {
								limits: type:   "object"
								requests: type: "object"
							}
						}
						metrics: type: "object"
						logging: {
							type: "object"
							properties: {
								loggers: type: "object"
								name: type:    "string"
								type: {
									type: "string"
									enum: [
										"inline",
										"external",
									]
								}
							}
							required: [
								"type",
							]
						}
						tlsSidecar: {
							type: "object"
							properties: {
								image: type: "string"
								livenessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								logLevel: {
									type: "string"
									enum: [
										"emerg",
										"alert",
										"crit",
										"err",
										"warning",
										"notice",
										"info",
										"debug",
									]
								}
								readinessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								resources: {
									type: "object"
									properties: {
										limits: type:   "object"
										requests: type: "object"
									}
								}
							}
						}
						template: {
							type: "object"
							properties: {
								statefulset: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								pod: {
									type: "object"
									properties: {
										metadata: {
											type: "object"
											properties: {
												labels: type:      "object"
												annotations: type: "object"
											}
										}
										imagePullSecrets: {
											type: "array"
											items: {
												type: "object"
												properties: name: type: "string"
											}
										}
										securityContext: {
											type: "object"
											properties: {
												fsGroup: type:      "integer"
												runAsGroup: type:   "integer"
												runAsNonRoot: type: "boolean"
												runAsUser: type:    "integer"
												seLinuxOptions: {
													type: "object"
													properties: {
														level: type: "string"
														role: type:  "string"
														type: type:  "string"
														user: type:  "string"
													}
												}
												supplementalGroups: {
													type: "array"
													items: type: "integer"
												}
												sysctls: {
													type: "array"
													items: {
														type: "object"
														properties: {
															name: type:  "string"
															value: type: "string"
														}
													}
												}
												windowsOptions: {
													type: "object"
													properties: {
														gmsaCredentialSpec: type:     "string"
														gmsaCredentialSpecName: type: "string"
													}
												}
											}
										}
										terminationGracePeriodSeconds: {
											type:    "integer"
											minimum: 0
										}
										affinity: {
											type: "object"
											properties: {
												nodeAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	preference: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchFields: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "object"
															properties: nodeSelectorTerms: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		matchExpressions: {
																			type: "array"
																			items: {
																				type: "object"
																				properties: {
																					key: type:      "string"
																					operator: type: "string"
																					values: {
																						type: "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchFields: {
																			type: "array"
																			items: {
																				type: "object"
																				properties: {
																					key: type:      "string"
																					operator: type: "string"
																					values: {
																						type: "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
												podAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	podAffinityTerm: {
																		type: "object"
																		properties: {
																			labelSelector: {
																				type: "object"
																				properties: {
																					matchExpressions: {
																						type: "array"
																						items: {
																							type: "object"
																							properties: {
																								key: type:      "string"
																								operator: type: "string"
																								values: {
																									type: "array"
																									items: type: "string"
																								}
																							}
																						}
																					}
																					matchLabels: type: "object"
																				}
																			}
																			namespaces: {
																				type: "array"
																				items: type: "string"
																			}
																			topologyKey: type: "string"
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	labelSelector: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchLabels: type: "object"
																		}
																	}
																	namespaces: {
																		type: "array"
																		items: type: "string"
																	}
																	topologyKey: type: "string"
																}
															}
														}
													}
												}
												podAntiAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	podAffinityTerm: {
																		type: "object"
																		properties: {
																			labelSelector: {
																				type: "object"
																				properties: {
																					matchExpressions: {
																						type: "array"
																						items: {
																							type: "object"
																							properties: {
																								key: type:      "string"
																								operator: type: "string"
																								values: {
																									type: "array"
																									items: type: "string"
																								}
																							}
																						}
																					}
																					matchLabels: type: "object"
																				}
																			}
																			namespaces: {
																				type: "array"
																				items: type: "string"
																			}
																			topologyKey: type: "string"
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	labelSelector: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchLabels: type: "object"
																		}
																	}
																	namespaces: {
																		type: "array"
																		items: type: "string"
																	}
																	topologyKey: type: "string"
																}
															}
														}
													}
												}
											}
										}
										priorityClassName: type: "string"
										schedulerName: type:     "string"
										tolerations: {
											type: "array"
											items: {
												type: "object"
												properties: {
													effect: type:            "string"
													key: type:               "string"
													operator: type:          "string"
													tolerationSeconds: type: "integer"
													value: type:             "string"
												}
											}
										}
									}
								}
								clientService: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								nodesService: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								persistentVolumeClaim: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								podDisruptionBudget: {
									type: "object"
									properties: {
										metadata: {
											type: "object"
											properties: {
												labels: type:      "object"
												annotations: type: "object"
											}
										}
										maxUnavailable: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								zookeeperContainer: {
									type: "object"
									properties: env: {
										type: "array"
										items: {
											type: "object"
											properties: {
												name: type:  "string"
												value: type: "string"
											}
										}
									}
								}
								tlsSidecarContainer: {
									type: "object"
									properties: env: {
										type: "array"
										items: {
											type: "object"
											properties: {
												name: type:  "string"
												value: type: "string"
											}
										}
									}
								}
							}
						}
					}
					required: [
						"replicas",
						"storage",
					]
				}
				topicOperator: {
					type: "object"
					properties: {
						watchedNamespace: type: "string"
						image: type:            "string"
						reconciliationIntervalSeconds: {
							type:    "integer"
							minimum: 0
						}
						zookeeperSessionTimeoutSeconds: {
							type:    "integer"
							minimum: 0
						}
						affinity: {
							type: "object"
							properties: {
								nodeAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													preference: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchFields: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "object"
											properties: nodeSelectorTerms: {
												type: "array"
												items: {
													type: "object"
													properties: {
														matchExpressions: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	key: type:      "string"
																	operator: type: "string"
																	values: {
																		type: "array"
																		items: type: "string"
																	}
																}
															}
														}
														matchFields: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	key: type:      "string"
																	operator: type: "string"
																	values: {
																		type: "array"
																		items: type: "string"
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
								podAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													podAffinityTerm: {
														type: "object"
														properties: {
															labelSelector: {
																type: "object"
																properties: {
																	matchExpressions: {
																		type: "array"
																		items: {
																			type: "object"
																			properties: {
																				key: type:      "string"
																				operator: type: "string"
																				values: {
																					type: "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																	matchLabels: type: "object"
																}
															}
															namespaces: {
																type: "array"
																items: type: "string"
															}
															topologyKey: type: "string"
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													labelSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													namespaces: {
														type: "array"
														items: type: "string"
													}
													topologyKey: type: "string"
												}
											}
										}
									}
								}
								podAntiAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													podAffinityTerm: {
														type: "object"
														properties: {
															labelSelector: {
																type: "object"
																properties: {
																	matchExpressions: {
																		type: "array"
																		items: {
																			type: "object"
																			properties: {
																				key: type:      "string"
																				operator: type: "string"
																				values: {
																					type: "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																	matchLabels: type: "object"
																}
															}
															namespaces: {
																type: "array"
																items: type: "string"
															}
															topologyKey: type: "string"
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													labelSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													namespaces: {
														type: "array"
														items: type: "string"
													}
													topologyKey: type: "string"
												}
											}
										}
									}
								}
							}
						}
						resources: {
							type: "object"
							properties: {
								limits: type:   "object"
								requests: type: "object"
							}
						}
						topicMetadataMaxAttempts: {
							type:    "integer"
							minimum: 0
						}
						tlsSidecar: {
							type: "object"
							properties: {
								image: type: "string"
								livenessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								logLevel: {
									type: "string"
									enum: [
										"emerg",
										"alert",
										"crit",
										"err",
										"warning",
										"notice",
										"info",
										"debug",
									]
								}
								readinessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								resources: {
									type: "object"
									properties: {
										limits: type:   "object"
										requests: type: "object"
									}
								}
							}
						}
						logging: {
							type: "object"
							properties: {
								loggers: type: "object"
								name: type:    "string"
								type: {
									type: "string"
									enum: [
										"inline",
										"external",
									]
								}
							}
							required: [
								"type",
							]
						}
						jvmOptions: {
							type: "object"
							properties: gcLoggingEnabled: type: "boolean"
						}
						livenessProbe: {
							type: "object"
							properties: {
								failureThreshold: type: "integer"
								initialDelaySeconds: {
									type:    "integer"
									minimum: 0
								}
								periodSeconds: type:    "integer"
								successThreshold: type: "integer"
								timeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
							}
						}
						readinessProbe: {
							type: "object"
							properties: {
								failureThreshold: type: "integer"
								initialDelaySeconds: {
									type:    "integer"
									minimum: 0
								}
								periodSeconds: type:    "integer"
								successThreshold: type: "integer"
								timeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
							}
						}
					}
				}
				entityOperator: {
					type: "object"
					properties: {
						topicOperator: {
							type: "object"
							properties: {
								watchedNamespace: type: "string"
								image: type:            "string"
								reconciliationIntervalSeconds: {
									type:    "integer"
									minimum: 0
								}
								zookeeperSessionTimeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
								livenessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								readinessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								resources: {
									type: "object"
									properties: {
										limits: type:   "object"
										requests: type: "object"
									}
								}
								topicMetadataMaxAttempts: {
									type:    "integer"
									minimum: 0
								}
								logging: {
									type: "object"
									properties: {
										loggers: type: "object"
										name: type:    "string"
										type: {
											type: "string"
											enum: [
												"inline",
												"external",
											]
										}
									}
									required: [
										"type",
									]
								}
								jvmOptions: {
									type: "object"
									properties: gcLoggingEnabled: type: "boolean"
								}
							}
						}
						userOperator: {
							type: "object"
							properties: {
								watchedNamespace: type: "string"
								image: type:            "string"
								reconciliationIntervalSeconds: {
									type:    "integer"
									minimum: 0
								}
								zookeeperSessionTimeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
								livenessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								readinessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								resources: {
									type: "object"
									properties: {
										limits: type:   "object"
										requests: type: "object"
									}
								}
								logging: {
									type: "object"
									properties: {
										loggers: type: "object"
										name: type:    "string"
										type: {
											type: "string"
											enum: [
												"inline",
												"external",
											]
										}
									}
									required: [
										"type",
									]
								}
								jvmOptions: {
									type: "object"
									properties: gcLoggingEnabled: type: "boolean"
								}
							}
						}
						affinity: {
							type: "object"
							properties: {
								nodeAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													preference: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchFields: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "object"
											properties: nodeSelectorTerms: {
												type: "array"
												items: {
													type: "object"
													properties: {
														matchExpressions: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	key: type:      "string"
																	operator: type: "string"
																	values: {
																		type: "array"
																		items: type: "string"
																	}
																}
															}
														}
														matchFields: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	key: type:      "string"
																	operator: type: "string"
																	values: {
																		type: "array"
																		items: type: "string"
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
								podAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													podAffinityTerm: {
														type: "object"
														properties: {
															labelSelector: {
																type: "object"
																properties: {
																	matchExpressions: {
																		type: "array"
																		items: {
																			type: "object"
																			properties: {
																				key: type:      "string"
																				operator: type: "string"
																				values: {
																					type: "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																	matchLabels: type: "object"
																}
															}
															namespaces: {
																type: "array"
																items: type: "string"
															}
															topologyKey: type: "string"
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													labelSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													namespaces: {
														type: "array"
														items: type: "string"
													}
													topologyKey: type: "string"
												}
											}
										}
									}
								}
								podAntiAffinity: {
									type: "object"
									properties: {
										preferredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													podAffinityTerm: {
														type: "object"
														properties: {
															labelSelector: {
																type: "object"
																properties: {
																	matchExpressions: {
																		type: "array"
																		items: {
																			type: "object"
																			properties: {
																				key: type:      "string"
																				operator: type: "string"
																				values: {
																					type: "array"
																					items: type: "string"
																				}
																			}
																		}
																	}
																	matchLabels: type: "object"
																}
															}
															namespaces: {
																type: "array"
																items: type: "string"
															}
															topologyKey: type: "string"
														}
													}
													weight: type: "integer"
												}
											}
										}
										requiredDuringSchedulingIgnoredDuringExecution: {
											type: "array"
											items: {
												type: "object"
												properties: {
													labelSelector: {
														type: "object"
														properties: {
															matchExpressions: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		key: type:      "string"
																		operator: type: "string"
																		values: {
																			type: "array"
																			items: type: "string"
																		}
																	}
																}
															}
															matchLabels: type: "object"
														}
													}
													namespaces: {
														type: "array"
														items: type: "string"
													}
													topologyKey: type: "string"
												}
											}
										}
									}
								}
							}
						}
						tolerations: {
							type: "array"
							items: {
								type: "object"
								properties: {
									effect: type:            "string"
									key: type:               "string"
									operator: type:          "string"
									tolerationSeconds: type: "integer"
									value: type:             "string"
								}
							}
						}
						tlsSidecar: {
							type: "object"
							properties: {
								image: type: "string"
								livenessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								logLevel: {
									type: "string"
									enum: [
										"emerg",
										"alert",
										"crit",
										"err",
										"warning",
										"notice",
										"info",
										"debug",
									]
								}
								readinessProbe: {
									type: "object"
									properties: {
										failureThreshold: type: "integer"
										initialDelaySeconds: {
											type:    "integer"
											minimum: 0
										}
										periodSeconds: type:    "integer"
										successThreshold: type: "integer"
										timeoutSeconds: {
											type:    "integer"
											minimum: 0
										}
									}
								}
								resources: {
									type: "object"
									properties: {
										limits: type:   "object"
										requests: type: "object"
									}
								}
							}
						}
						template: {
							type: "object"
							properties: {
								deployment: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								pod: {
									type: "object"
									properties: {
										metadata: {
											type: "object"
											properties: {
												labels: type:      "object"
												annotations: type: "object"
											}
										}
										imagePullSecrets: {
											type: "array"
											items: {
												type: "object"
												properties: name: type: "string"
											}
										}
										securityContext: {
											type: "object"
											properties: {
												fsGroup: type:      "integer"
												runAsGroup: type:   "integer"
												runAsNonRoot: type: "boolean"
												runAsUser: type:    "integer"
												seLinuxOptions: {
													type: "object"
													properties: {
														level: type: "string"
														role: type:  "string"
														type: type:  "string"
														user: type:  "string"
													}
												}
												supplementalGroups: {
													type: "array"
													items: type: "integer"
												}
												sysctls: {
													type: "array"
													items: {
														type: "object"
														properties: {
															name: type:  "string"
															value: type: "string"
														}
													}
												}
												windowsOptions: {
													type: "object"
													properties: {
														gmsaCredentialSpec: type:     "string"
														gmsaCredentialSpecName: type: "string"
													}
												}
											}
										}
										terminationGracePeriodSeconds: {
											type:    "integer"
											minimum: 0
										}
										affinity: {
											type: "object"
											properties: {
												nodeAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	preference: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchFields: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "object"
															properties: nodeSelectorTerms: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		matchExpressions: {
																			type: "array"
																			items: {
																				type: "object"
																				properties: {
																					key: type:      "string"
																					operator: type: "string"
																					values: {
																						type: "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchFields: {
																			type: "array"
																			items: {
																				type: "object"
																				properties: {
																					key: type:      "string"
																					operator: type: "string"
																					values: {
																						type: "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
												podAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	podAffinityTerm: {
																		type: "object"
																		properties: {
																			labelSelector: {
																				type: "object"
																				properties: {
																					matchExpressions: {
																						type: "array"
																						items: {
																							type: "object"
																							properties: {
																								key: type:      "string"
																								operator: type: "string"
																								values: {
																									type: "array"
																									items: type: "string"
																								}
																							}
																						}
																					}
																					matchLabels: type: "object"
																				}
																			}
																			namespaces: {
																				type: "array"
																				items: type: "string"
																			}
																			topologyKey: type: "string"
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	labelSelector: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchLabels: type: "object"
																		}
																	}
																	namespaces: {
																		type: "array"
																		items: type: "string"
																	}
																	topologyKey: type: "string"
																}
															}
														}
													}
												}
												podAntiAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	podAffinityTerm: {
																		type: "object"
																		properties: {
																			labelSelector: {
																				type: "object"
																				properties: {
																					matchExpressions: {
																						type: "array"
																						items: {
																							type: "object"
																							properties: {
																								key: type:      "string"
																								operator: type: "string"
																								values: {
																									type: "array"
																									items: type: "string"
																								}
																							}
																						}
																					}
																					matchLabels: type: "object"
																				}
																			}
																			namespaces: {
																				type: "array"
																				items: type: "string"
																			}
																			topologyKey: type: "string"
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	labelSelector: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchLabels: type: "object"
																		}
																	}
																	namespaces: {
																		type: "array"
																		items: type: "string"
																	}
																	topologyKey: type: "string"
																}
															}
														}
													}
												}
											}
										}
										priorityClassName: type: "string"
										schedulerName: type:     "string"
										tolerations: {
											type: "array"
											items: {
												type: "object"
												properties: {
													effect: type:            "string"
													key: type:               "string"
													operator: type:          "string"
													tolerationSeconds: type: "integer"
													value: type:             "string"
												}
											}
										}
									}
								}
								tlsSidecarContainer: {
									type: "object"
									properties: env: {
										type: "array"
										items: {
											type: "object"
											properties: {
												name: type:  "string"
												value: type: "string"
											}
										}
									}
								}
								topicOperatorContainer: {
									type: "object"
									properties: env: {
										type: "array"
										items: {
											type: "object"
											properties: {
												name: type:  "string"
												value: type: "string"
											}
										}
									}
								}
								userOperatorContainer: {
									type: "object"
									properties: env: {
										type: "array"
										items: {
											type: "object"
											properties: {
												name: type:  "string"
												value: type: "string"
											}
										}
									}
								}
							}
						}
					}
				}
				clusterCa: {
					type: "object"
					properties: {
						generateCertificateAuthority: type: "boolean"
						validityDays: {
							type:    "integer"
							minimum: 1
						}
						renewalDays: {
							type:    "integer"
							minimum: 1
						}
						certificateExpirationPolicy: {
							type: "string"
							enum: [
								"renew-certificate",
								"replace-key",
							]
						}
					}
				}
				clientsCa: {
					type: "object"
					properties: {
						generateCertificateAuthority: type: "boolean"
						validityDays: {
							type:    "integer"
							minimum: 1
						}
						renewalDays: {
							type:    "integer"
							minimum: 1
						}
						certificateExpirationPolicy: {
							type: "string"
							enum: [
								"renew-certificate",
								"replace-key",
							]
						}
					}
				}
				jmxTrans: {
					type: "object"
					properties: {
						image: type: "string"
						outputDefinitions: {
							type: "array"
							items: {
								type: "object"
								properties: {
									outputType: type:          "string"
									host: type:                "string"
									port: type:                "integer"
									flushDelayInSeconds: type: "integer"
									typeNames: {
										type: "array"
										items: type: "string"
									}
									name: type: "string"
								}
								required: [
									"outputType",
									"name",
								]
							}
						}
						logLevel: type: "string"
						kafkaQueries: {
							type: "array"
							items: {
								type: "object"
								properties: {
									targetMBean: type: "string"
									attributes: {
										type: "array"
										items: type: "string"
									}
									outputs: {
										type: "array"
										items: type: "string"
									}
								}
								required: [
									"targetMBean",
									"attributes",
									"outputs",
								]
							}
						}
						resources: {
							type: "object"
							properties: {
								limits: type:   "object"
								requests: type: "object"
							}
						}
					}
					required: [
						"outputDefinitions",
						"kafkaQueries",
					]
				}
				kafkaExporter: {
					type: "object"
					properties: {
						image: type:      "string"
						groupRegex: type: "string"
						topicRegex: type: "string"
						resources: {
							type: "object"
							properties: {
								limits: type:   "object"
								requests: type: "object"
							}
						}
						logging: type:             "string"
						enableSaramaLogging: type: "boolean"
						template: {
							type: "object"
							properties: {
								deployment: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								pod: {
									type: "object"
									properties: {
										metadata: {
											type: "object"
											properties: {
												labels: type:      "object"
												annotations: type: "object"
											}
										}
										imagePullSecrets: {
											type: "array"
											items: {
												type: "object"
												properties: name: type: "string"
											}
										}
										securityContext: {
											type: "object"
											properties: {
												fsGroup: type:      "integer"
												runAsGroup: type:   "integer"
												runAsNonRoot: type: "boolean"
												runAsUser: type:    "integer"
												seLinuxOptions: {
													type: "object"
													properties: {
														level: type: "string"
														role: type:  "string"
														type: type:  "string"
														user: type:  "string"
													}
												}
												supplementalGroups: {
													type: "array"
													items: type: "integer"
												}
												sysctls: {
													type: "array"
													items: {
														type: "object"
														properties: {
															name: type:  "string"
															value: type: "string"
														}
													}
												}
												windowsOptions: {
													type: "object"
													properties: {
														gmsaCredentialSpec: type:     "string"
														gmsaCredentialSpecName: type: "string"
													}
												}
											}
										}
										terminationGracePeriodSeconds: {
											type:    "integer"
											minimum: 0
										}
										affinity: {
											type: "object"
											properties: {
												nodeAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	preference: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchFields: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "object"
															properties: nodeSelectorTerms: {
																type: "array"
																items: {
																	type: "object"
																	properties: {
																		matchExpressions: {
																			type: "array"
																			items: {
																				type: "object"
																				properties: {
																					key: type:      "string"
																					operator: type: "string"
																					values: {
																						type: "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																		matchFields: {
																			type: "array"
																			items: {
																				type: "object"
																				properties: {
																					key: type:      "string"
																					operator: type: "string"
																					values: {
																						type: "array"
																						items: type: "string"
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
												podAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	podAffinityTerm: {
																		type: "object"
																		properties: {
																			labelSelector: {
																				type: "object"
																				properties: {
																					matchExpressions: {
																						type: "array"
																						items: {
																							type: "object"
																							properties: {
																								key: type:      "string"
																								operator: type: "string"
																								values: {
																									type: "array"
																									items: type: "string"
																								}
																							}
																						}
																					}
																					matchLabels: type: "object"
																				}
																			}
																			namespaces: {
																				type: "array"
																				items: type: "string"
																			}
																			topologyKey: type: "string"
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	labelSelector: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchLabels: type: "object"
																		}
																	}
																	namespaces: {
																		type: "array"
																		items: type: "string"
																	}
																	topologyKey: type: "string"
																}
															}
														}
													}
												}
												podAntiAffinity: {
													type: "object"
													properties: {
														preferredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	podAffinityTerm: {
																		type: "object"
																		properties: {
																			labelSelector: {
																				type: "object"
																				properties: {
																					matchExpressions: {
																						type: "array"
																						items: {
																							type: "object"
																							properties: {
																								key: type:      "string"
																								operator: type: "string"
																								values: {
																									type: "array"
																									items: type: "string"
																								}
																							}
																						}
																					}
																					matchLabels: type: "object"
																				}
																			}
																			namespaces: {
																				type: "array"
																				items: type: "string"
																			}
																			topologyKey: type: "string"
																		}
																	}
																	weight: type: "integer"
																}
															}
														}
														requiredDuringSchedulingIgnoredDuringExecution: {
															type: "array"
															items: {
																type: "object"
																properties: {
																	labelSelector: {
																		type: "object"
																		properties: {
																			matchExpressions: {
																				type: "array"
																				items: {
																					type: "object"
																					properties: {
																						key: type:      "string"
																						operator: type: "string"
																						values: {
																							type: "array"
																							items: type: "string"
																						}
																					}
																				}
																			}
																			matchLabels: type: "object"
																		}
																	}
																	namespaces: {
																		type: "array"
																		items: type: "string"
																	}
																	topologyKey: type: "string"
																}
															}
														}
													}
												}
											}
										}
										priorityClassName: type: "string"
										schedulerName: type:     "string"
										tolerations: {
											type: "array"
											items: {
												type: "object"
												properties: {
													effect: type:            "string"
													key: type:               "string"
													operator: type:          "string"
													tolerationSeconds: type: "integer"
													value: type:             "string"
												}
											}
										}
									}
								}
								service: {
									type: "object"
									properties: metadata: {
										type: "object"
										properties: {
											labels: type:      "object"
											annotations: type: "object"
										}
									}
								}
								container: {
									type: "object"
									properties: env: {
										type: "array"
										items: {
											type: "object"
											properties: {
												name: type:  "string"
												value: type: "string"
											}
										}
									}
								}
							}
						}
						livenessProbe: {
							type: "object"
							properties: {
								failureThreshold: type: "integer"
								initialDelaySeconds: {
									type:    "integer"
									minimum: 0
								}
								periodSeconds: type:    "integer"
								successThreshold: type: "integer"
								timeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
							}
						}
						readinessProbe: {
							type: "object"
							properties: {
								failureThreshold: type: "integer"
								initialDelaySeconds: {
									type:    "integer"
									minimum: 0
								}
								periodSeconds: type:    "integer"
								successThreshold: type: "integer"
								timeoutSeconds: {
									type:    "integer"
									minimum: 0
								}
							}
						}
					}
				}
				maintenanceTimeWindows: {
					type: "array"
					items: type: "string"
				}
			}
			required: [
				"kafka",
				"zookeeper",
			]
		}
		status: {
			type: "object"
			properties: {
				conditions: {
					type: "array"
					items: {
						type: "object"
						properties: {
							type: type:               "string"
							status: type:             "string"
							lastTransitionTime: type: "string"
							reason: type:             "string"
							message: type:            "string"
						}
					}
				}
				observedGeneration: type: "integer"
				listeners: {
					type: "array"
					items: {
						type: "object"
						properties: {
							type: type: "string"
							addresses: {
								type: "array"
								items: {
									type: "object"
									properties: {
										host: type: "string"
										port: type: "integer"
									}
								}
							}
							certificates: {
								type: "array"
								items: type: "string"
							}
						}
					}
				}
			}
		}
	}
}
