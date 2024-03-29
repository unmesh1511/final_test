#!/bin/bash

source iox.config

DIO_UNID="${IOX_INSTALL_ID}.dio"
METER_UNID="${IOX_INSTALL_ID}.meter"

# Recommend syntax for setting an infinite while loop
echo "*********** starting test *************"
#mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do -m '{
#    "action":"create",
#        "args": {
#               "unid":"'${DIO_UNID}'",
#                      "type":"900001050304DD00-5",
#                             "provision":true
#                                 }  
#                             }'
#
#sleep 10   
#mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do -m '{
#    "action":"create",
#        "args": {
#               "unid":"'${METER_UNID}'",
#                      "type":"900001150004DD00",
#                             "provision":true
#                           }  
#                         }'
#                         
sleep 10
mosquitto_pub -m '{"action":"provision","args":{"unid":"'${DIO_UNID}'"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
sleep 2
mosquitto_pub -m '{"action":"provision","args":{"unid":"'${METER_UNID}'"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
sleep 2

mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/0 -m '{
 "cpPhaseEnable": {
                 "value" : {
                         "L1_Phase" : 1,
                         "L2_Phase" : 1,
                         "L3_Phase" : 1
                        }
                     },
 "cpCtRatio": {
               "value" : {
                      "L1_ctRatio" : {
                      "multiplier" : 10
                      },
                      "L2_ctRatio" : {
                      "multiplier" : 10
                       },
                       "L3_ctRatio" : {
                       "multiplier" : 10
                  }
              }
            },  
 "nvoVoltageRMS": {    
              "monitor":        {
                      "rate":50,
                       "cat":"data",
                      "inFeedback":false,
                       "report":"change",
                     "throttle":21,
                      "threshold":31
                               }
               },
 "nvoVoltageAvg": {
               "monitor":        {
                  "rate":50,
                   "cat":"data",
                 "inFeedback":false,
                  "report":"change",
                   "throttle":21,
                     "threshold":31
                     }
              },
 "nvoCurrentRMS": {
                "monitor":        {
                            "rate":50,
                            "cat":"data",
                            "inFeedback":false,
                            "report":"change",
                            "throttle":22,
                            "threshold":32
                                   }
                  },
 "nvoActiveEnergy": {
                 "monitor":        {
                          "rate":50,
                          "cat":"data",
                           "inFeedback":false,
                           "report":"change",
                         "throttle":22,
                         "threshold":32
                                  }
                  },
 "nvoReactEnergy": {
               "monitor":        {
                       "rate":50,
                       "cat":"data",
                       "inFeedback":false,
                       "report":"change",
                       "throttle":22,
                       "threshold":32
                        }
                 },
 "nvoAppEnergy": {
               "monitor":        {
                   "rate":50,
                   "cat":"data",
                   "inFeedback":false,
                   "report":"change",
                      "throttle":22,
                      "threshold":32
                  }
              },
              "nvoPhaseActEnergy": {
              "monitor":        {
              "rate":50,
              "cat":"data",
              "inFeedback":false,
              "report":"change",
              "throttle":22,
              "threshold":32
          }
      },
      "nvoPhaseRctEnergy": {
      "monitor":        {
      "rate":50,
      "cat":"data",
      "inFeedback":false,
      "report":"change",
      "throttle":22,
      "threshold":32
  }
                },
                "nvoPhaseAppEnergy": {
                "monitor":        {
                "rate":50,
                "cat":"data",
                "inFeedback":false,
                "report":"change",
                "throttle":22,
                "threshold":32
            }
        },
        "nvoPower": {
        "monitor":        {
        "rate":50,
        "cat":"data",
        "inFeedback":false,
        "report":"change",
        "throttle":22,
        "threshold":32
    }
},
                 "nvoPhaseActPwr": {
                 "monitor":        {
                 "rate":50,
                 "cat":"data",
                 "inFeedback":false,
                 "report":"change",
                 "throttle":22,
                 "threshold":32
             }
         },
         "nvoPhaseReactPwr": {
         "monitor":        {
         "rate":50,
         "cat":"data",
         "inFeedback":false,
         "report":"change",
         "throttle":22,
         "threshold":32
     }
 },
 "nvoPhaseAppPwr": {
 "monitor":        {
 "rate":50,
 "cat":"data",
 "inFeedback":false,
 "report":"change",
 "throttle":22,
 "threshold":32
                        }
                    },
                    "nvoPowerStatus": {
                    "monitor":        {
                    "rate":50,
                    "cat":"data",
                    "inFeedback":false,
                    "report":"change",
                    "throttle":22,
                    "threshold":32
                }
            },
            "nvoPhaseFrequency": {
            "monitor":        {
            "rate":50,
            "cat":"data",
            "inFeedback":false,
            "report":"change",
            "throttle":22,
            "threshold":32
        }
    }
}'
sleep 5
mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1 -m '{
"input": {
"monitor": {
"rate":50,
"cat": "data",
"inFeedback": true,
"report": "change",
"throttle": 0,
"threshold": 10
                                                 }
                                             },
                                             "mode": {
                                             "value": {
                                             "type": "frequency",
                                             "level": {
                                             "detect-level": 0,
                                             "pullup-cfg": true
                                         },
                                         "pulse": {
                                         "detect-level": 0,
                                         "pullup-cfg": true
                                     },
                                     "frequency": {
                                     "detect-level": 0,
                                     "pullup-cfg": true
                                 }
                             }
                         }
                     }'
                     sleep 2;
mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/2 -m '{
"input": {
"monitor": {
"rate":50,
"cat": "data",
"inFeedback": true,
"report": "change",
"throttle": 0,
"threshold": 10
                                                 }
                                             },
                                             "mode": {
                                             "value": {
                                             "type": "frequency",
                                             "level": {
                                             "detect-level": 0,
                                             "pullup-cfg": true
                                         },
                                         "pulse": {
                                         "detect-level": 0,
                                         "pullup-cfg": true
                                     },
                                     "frequency": {
                                     "detect-level": 0,
                                     "pullup-cfg": true
                                 }
                             }
                         }
                     }'
                     sleep 2;
mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/3 -m '{
"input": {
"monitor": {
"rate":50,
"cat": "data",
"inFeedback": true,
"report": "change",
"throttle": 0,
"threshold": 10
                                                 }
                                             },
                                             "mode": {
                                             "value": {
                                             "type": "frequency",
                                             "level": {
                                             "detect-level": 0,
                                             "pullup-cfg": true
                                         },
                                         "pulse": {
                                         "detect-level": 0,
                                         "pullup-cfg": true
                                     },
                                     "frequency": {
                                     "detect-level": 0,
                                     "pullup-cfg": true
                                 }
                             }
                         }
                     }'
                     sleep 2;
mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/4 -m '{
"input": {
"monitor": {
"rate":50,
"cat": "data",
"inFeedback": true,
"report": "change",
"throttle": 0,
"threshold": 10
                                                 }
                                             },
                                             "mode": {
                                             "value": {
                                             "type": "frequency",
                                             "level": {
                                             "detect-level": 0,
                                             "pullup-cfg": true
                                         },
                                         "pulse": {
                                         "detect-level": 0,
                                         "pullup-cfg": true
                                     },
                                     "frequency": {
                                     "detect-level": 0,
                                     "pullup-cfg": true
                                 }
                             }
                         }
                     }'
                     sleep 2;
mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/5 -m '{
"input": {
"monitor": {
"rate":50,
"cat": "data",
"inFeedback": true,
"report": "change",
"throttle": 0,
"threshold": 10
                                                 }
                                             },
                                             "mode": {
                                             "value": {
                                             "type": "frequency",
                                             "level": {
                                             "detect-level": 0,
                                             "pullup-cfg": true
                                         },
                                         "pulse": {
                                         "detect-level": 0,
                                         "pullup-cfg": true
                                     },
                                     "frequency": {
                                     "detect-level": 0,
                                     "pullup-cfg": true
                                 }
                             }
                         }
                     }'
                     sleep 2;
mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/6 -m '{
"input": {
"monitor": {
"rate":50,
"cat": "data",
"inFeedback": true,
"report": "change",
"throttle": 0,
"threshold": 10
                                                 }
                                             },
                                             "mode": {
                                             "value": {
                                             "type": "frequency",
                                             "level": {
                                             "detect-level": 0,
                                             "pullup-cfg": true
                                         },
                                         "pulse": {
                                         "detect-level": 0,
                                         "pullup-cfg": true
                                     },
                                     "frequency": {
                                     "detect-level": 0,
                                     "pullup-cfg": true
                                 }
                             }
                         }
                     }'
                     sleep 2;
mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/7 -m '{
"input": {
"monitor": {
"rate":50,
"cat": "data",
"inFeedback": true,
"report": "change",
"throttle": 0,
"threshold": 10
                                                 }
                                             },
                                             "mode": {
                                             "value": {
                                             "type": "frequency",
                                             "level": {
                                             "detect-level": 0,
                                             "pullup-cfg": true
                                         },
                                         "pulse": {
                                         "detect-level": 0,
                                         "pullup-cfg": true
                                     },
                                     "frequency": {
                                     "detect-level": 0,
                                     "pullup-cfg": true
                                 }
                             }
                         }
                     }'
                     sleep 2;
mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/8 -m '{
"input": {
"monitor": {
"rate":50,
"cat": "data",
"inFeedback": true,
"report": "change",
"throttle": 0,
"threshold": 10
                                                 }
                                             },
                                             "mode": {
                                             "value": {
                                             "type": "frequency",
                                             "level": {
                                             "detect-level": 0,
                                             "pullup-cfg": true
                                         },
                                         "pulse": {
                                         "detect-level": 0,
                                         "pullup-cfg": true
                                     },
                                     "frequency": {
                                     "detect-level": 0,
                                     "pullup-cfg": true
                                 }
                             }
                         }
                     }'
                     sleep 2;
while :
do
	echo "*********** In test *************"
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1 -m '{
	"relay-val": {
	            "value": {
	            "level": true
	 	     }       
	         }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/2 -m '{
	"relay-val": {
	            "value": {
	            "level": true
	 	     }       
	         }
	}'
	
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 10,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/2 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 10,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/3 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 10,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/4 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 10,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/5 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 10,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/6 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 10,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	    sleep 40
	   mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1 -m '{
	"relay-val": {
	            "value": {
	            "level": false
	 	     }       
	         }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/2 -m '{
	"relay-val": {
	            "value": {
	            "level": false
	 	     }       
	         }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 5,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/2 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 5,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/3 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 5,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/4 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 5,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/5 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 5,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	sleep 1
	mosquitto_pub -t glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/6 -m '{
	"output": {
	          "value": {
	                 "level": false,
	                 "frequency": 5,
	                 "pulse_counter": {
	                                 "Pulse_pwm": {
	                                             "pulse": 300,
	                                             "pwm": {
	                                                  "frequency": 20000,
	                                                  "duty_cycle": 90
	                                                    }
	                                              }
	                                  }
	                    }
	          },
	"mode": {
	        "value": {
	                 "type": "frequency"
	                 }
	        }
	}'
	    sleep 10
	    echo "Do something; hit [CTRL+C] to stop!"
	(sleep 1; echo "heapinfo"; sleep 3;  echo "exit") | telnet ${IOX_IP}
done
