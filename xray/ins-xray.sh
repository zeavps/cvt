#!/bin/bash
# @ Copyrigt 2021 By zerossl
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

MYIP=$(wget -qO- ipinfo.io/ip);
clear
domain=$(cat /root/domain)
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Jakarta
chronyc sourcestats -v
chronyc tracking -v
date

# / / Ambil Xray Core Version Terbaru
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

# / / Installation Xray Core
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/xray-linux-64.zip"

# / / Make Main Directory
mkdir -p /usr/bin/xray
mkdir -p /etc/xray

# / / Unzip Xray Linux 64
cd `mktemp -d`
curl -sL "$xraycore_link" -o xray.zip
unzip -q xray.zip && rm -rf xray.zip
mv xray /usr/local/bin/xray
chmod +x /usr/local/bin/xray

# Make Folder XRay
mkdir -p /var/log/xray/
uuid=$(cat /proc/sys/kernel/random/uuid)
#bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u root
cd /root/
#wget https://raw.githubusercontent.com/acmesh-official/acme.sh/master/acme.sh

sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
##Generate acme certificate
curl https://get.acme.sh | sh
alias acme.sh=~/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d "${domain}" --standalone --keylength ec-256
/root/.acme.sh/acme.sh --install-cert -d "${domain}" --ecc \
--fullchain-file /etc/xray/xray.crt \
--key-file /etc/xray/xray.key
chown -R nobody:nogroup /etc/xray
chmod 644 /etc/xray/xray.crt
chmod 644 /etc/xray/xray.key

sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
#cd /root/
#wget https://raw.githubusercontent.com/acmesh-official/acme.sh/master/acme.sh
#bash acme.sh --install
#bash acme.sh --register-account -m inoyaksorojawi@gmail.com
#bash acme.sh --issue --standalone -d $domain --force
#bash acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key

#curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
#chmod +x /root/.acme.sh/acme.sh
#/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
#~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc

uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat /root/domain)
# // Certificate File
path_crt="/etc/xray/xray.crt"
path_key="/etc/xray/xray.key"
#domain_ecc=$(cat /root/.acme.sh)
#domain.key=$(cat /root/.acme.sh/$domain_ecc)
#path_crt="/root/.acme.sh/$domain_ecc/fullchain.cer"
#path_key="/root/.acme.sh/$domain_ecc/$domain.key"
# Buat Config Xray
cat > /etc/xray/config.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": 8088 ,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "alterId": 0
#vmess-http-tls
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "httpSettings": {},
        "tcpSettings": {
          "header": {
            "type": "http",
            "request": {
              "version": "1.1",
              "method": "GET",
              "path": [
                "/"
              ],
              "headers": {
                "Host": "${domain}",
                "User-Agent": [
                  "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36",
                  "Mozilla/5.0 (iPhone; CPU iPhone OS 10_0_2 like Mac OS X) AppleWebKit/601.1 (KHTML, like Gecko) CriOS/53.0.2785.109 Mobile/14A456 Safari/601.1.46"
                ],
                "Accept-Encoding": [
                  "gzip, deflate"
                ],
                "Connection": [
                  "keep-alive"
                ],
                "Pragma": "no-cache"
              }
            },
            "response": {
              "version": "1.1",
              "status": "200",
              "reason": "OK",
              "headers": {
                "Content-Type": [
                  "application/octet-stream",
                  "video/mpeg"
                ],
                "Transfer-Encoding": [
                  "chunked"
                ],
                "Connection": [
                  "keep-alive"
                ],
                "Pragma": "no-cache"
              }
            }
          }
        },
        "kcpSettings": {},
        "wsSettings": {},
        "quicSettings": {}
      },
      "domain": "${domain}",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "port": 99,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-direct"
#vless-xtls
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 88
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "tcpSettings": {},
        "kcpSettings": {},
        "wsSettings": {},
        "httpSettings": {},
        "quicSettings": {},
        "grpcSettings": {},
        "xtlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ],
          "alpn": [
            "http/1.1"
          ]
        }
      },
      "domain": "${domain}",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "port": 808,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "alterId": 0
#vmess-http-nontls
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tlsSettings": {},
        "httpSettings": {},
        "tcpSettings": {
          "header": {
            "type": "http",
            "request": {
              "version": "1.1",
              "method": "GET",
              "path": [
                "/"
              ],
              "headers": {
                "Host": "vmbsmm.cnom.net",
                "User-Agent": [
                  "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36",
                  "Mozilla/5.0 (iPhone; CPU iPhone OS 10_0_2 like Mac OS X) AppleWebKit/601.1 (KHTML, like Gecko) CriOS/53.0.2785.109 Mobile/14A456 Safari/601.1.46"
                ],
                "Accept-Encoding": [
                  "gzip, deflate"
                ],
                "Connection": [
                  "keep-alive"
                ],
                "Pragma": "no-cache"
              }
            },
            "response": {
              "version": "1.1",
              "status": "200",
              "reason": "OK",
              "headers": {
                "Content-Type": [
                  "application/octet-stream",
                  "video/mpeg"
                ],
                "Transfer-Encoding": [
                  "chunked"
                ],
                "Connection": [
                  "keep-alive"
                ],
                "Pragma": "no-cache"
              }
            }
          }
        },
        "kcpSettings": {},
        "wsSettings": {},
        "quicSettings": {}
      }
    },
    {
      "port": 2053,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "alterId": 0
#vmess-tls
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "tcpSettings": {},
        "kcpSettings": {},
        "httpSettings": {},
        "wsSettings": {
          "path": "/gandring",
          "headers": {
            "Host": "${domain}"
          }
        },
        "quicSettings": {}
      },
      "domain": "${domain}"
    },
    {
      "port": 2052,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "alterId": 0
#vmess-nontls
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "tlsSettings": {},
        "tcpSettings": {},
        "kcpSettings": {},
        "httpSettings": {},
        "wsSettings": {
          "path": "/gandring",
          "headers": {
            "Host": "${domain}"
          }
        },
        "quicSettings": {}
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "port": 1001,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "alterId": 0
#vmess-hdua
          }
        ]
      },
      "streamSettings": {
        "network": "h2",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "tcpSettings": {},
        "httpSettings": {
          "path": "/gandring"
        },
        "kcpSettings": {},
        "wsSettings": {},
        "quicSettings": {}
      },
      "domain": "${domain}",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "port": 2087,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#vless-tls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ],
          "alpn": [
            "http/1.1"
          ]
        },
        "tcpSettings": {},
        "kcpSettings": {},
        "httpSettings": {},
        "wsSettings": {
          "path": "/gandring",
          "headers": {
            "Host": "${domain}"
          }
        },
        "quicSettings": {}
      },
      "domain": "${domain}",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "port": 2086,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#vless-nontls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "tlsSettings": {},
        "tcpSettings": {},
        "kcpSettings": {},
        "httpSettings": {},
        "wsSettings": {
          "path": "/gandring",
          "headers": {
            "Host": "${domain}"
          }
        },
        "quicSettings": {}
      }
    },
    {
      "port": 333,
      "protocol": "shadowsocks",
      "settings": {
        "method": "chacha20-poly1305",
        "password": "gandring",
#xray-ss
        "network": "tcp,udp"
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "tag": "K",
      "port": 111,
      "protocol": "mtproto",
      "settings": {
        "users": [
          {
            "secret": "abdff3490fe6bb16fbd57f4f45d7215a"
#xray-mtproto
          }
        ]
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "port": 999,
      "protocol": "socks",
      "settings": {
        "auth": "password",
        "accounts": [
          {
            "user": "gandring",
            "pass": "gandring"
          }
        ],
        "udp": true
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tlsSettings": {},
        "tcpSettings": {},
        "kcpSettings": {},
        "wsSettings": {},
        "httpSettings": {},
        "quicSettings": {},
        "grpcSettings": {}
      }
    },
    {
      "port": 1080,
      "protocol": "socks",
      "settings": {
        "auth": "password",
        "accounts": [
          {
            "user": "gandring",
            "pass": "gandring"
#xray-socks
          }
        ],
        "udp": true
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "tcpSettings": {},
        "kcpSettings": {},
        "wsSettings": {
          "path": "/gandring",
          "headers": {
            "Host": "${domain}"
          }
        },
        "httpSettings": {},
        "quicSettings": {},
        "grpcSettings": {}
      },
      "domain": "${domain}"
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    },
    {
      "tag": "tg-out",
      "protocol": "mtproto",
      "settings": {}
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "type": "field",
        "inboundTag": [
          "K"
        ],
        "outboundTag": "tg-out"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END

uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat /root/domain)
# // Certificate File
path_crt="/etc/xray/xray.crt"
path_key="/etc/xray/xray.key"
#domain_ecc=$(cat /root/.acme.sh)
#domain.key=$(cat /root/.acme.sh/$domain_ecc)
#path_crt="/root/.acme.sh/$domain_ecc/fullchain.cer"
#path_key="/root/.acme.sh/$domain_ecc/$domain.key"
# Buat Config Xray
cat > /etc/xray/xtrojan.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": 4443,
      "protocol": "trojan",
      "tag": "TROJAN-xtls-in",
      "settings": {
        "clients": [
          {
            "password": "gandring",
            "flow": "xtls-rprx-direct",
            "email": "gandring@p0x.smule.my.id",
            "level": 0
#trojan-xtls
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 443,
            "xver": 1
          },
          {
            "path": "/gandring",
            "dest": 2096,
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "alpn": [
            "h2",
            "http/1.1"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        }
      }
    },
    {
      "port": 8443,
      "listen": "0.0.0.0",
      "protocol": "trojan",
      "tag": "TROJAN-gRPC-in",
      "settings": {
        "clients": [
          {
            "password": "gandring",
            "email": "gandring@p0x.smule.my.id"
#trojan-grpc
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "grpc",
        "security": "tls",
        "tlsSettings": {
          "serverName": "",
          "alpn": [
            "h2",
            "http/1.1"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "grpcSettings": {
          "serviceName": "gandring"
        }
      }
    },
    {
      "port": 2096,
      "listen": "0.0.0.0",
      "protocol": "trojan",
      "tag": "TROJAN-WSTLS-in",
      "settings": {
        "clients": [
          {
            "password": "gandring",
            "email": "gandring@p0x.smule.my.id"
#trojan-tls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "wsSettings": {
          "path": "/gandring"
         },
         "tlsSettings": {
          "alpn": [
            "h2",
            "http/1.1"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        }
      }
    },
    {
      "port": 2095,
      "listen": "0.0.0.0",
      "protocol": "trojan",
      "tag": "TROJAN-WS-in",
      "settings": {
        "clients": [
          {
            "password": "gandring",
            "email": "gandring@p0x.smule.my.id"
#trojan-nontls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "path": "/gandring"
        }
      }
    },
    {
      "port": 888,
      "listen": "0.0.0.0",
      "protocol": "trojan",
      "tag": "TROJAN-HTTP/2-in",
      "settings": {
        "clients": [
          {
            "password": "gandring",
            "email": "gandring@p0x.smule.my.id"
#trojan-hdua
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "h2",
        "security": "tls",
        "httpSettings": {
          "path": "/gandring"
         },
         "tlsSettings": {
          "alpn": [
            "h2",
            "http/1.1"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        }
      }
    },
    {
      "port": 880,
      "listen": "0.0.0.0",
      "protocol": "trojan",
      "tag": "TROJAN-HTTP-in",
      "settings": {
        "clients": [
          {
            "password": "gandring",
            "email": "gandring@p0x.smule.my.id"
#trojan-http
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {
         "header": {
          "type": "http",
           "response": {
            "version": "1.1",
             "status": "200",
             "reason": "OK",
             "headers": {}
            }
          }
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "tag": "blocked"
    }
  ],
  "dns": {
    "servers": [
      "1.1.1.1",
      "1.0.0.1",
      "localhost",
      "https+local://1.1.1.1/dns-query"
    ]
  },
  "routing":{
        "domainStrategy": "AsIs",
        "rules": [
          {
            "type": "field",
            "outboundTag": "blackhole-out",
            "protocol": [ "bittorrent" ]
          }
      ]
   }
}
END

uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat /root/domain)
# // Certificate File
path_crt="/etc/xray/xray.crt"
path_key="/etc/xray/xray.key"
#domain_ecc=$(cat /root/.acme.sh)
#domain.key=$(cat /root/.acme.sh/$domain_ecc)
#path_crt="/root/.acme.sh/$domain_ecc/fullchain.cer"
#path_key="/root/.acme.sh/$domain_ecc/$domain.key"
# Buat Config Xray
cat > /etc/xray/xvless.json << END
{
    "log": {
            "access": "/var/log/xray/access.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 2053,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "alterid": 0
#vmess-grpc-tls
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "grpc",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "http/1.1",
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                "acceptProxyProtocol": true,
                    "serviceName": "gandring"
                }
            }
        },
        {
            "port": 1000,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "alterid": 0
#vmess-grpc-nontls
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "grpc",
                "security": "none",
                "serverName": "$domain",
                "grpcSettings": {
                "acceptProxyProtocol": true,
                    "serviceName": "gandring"
                }
            }
        },
        {
            "port": 2083,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vless-grpc-tls
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "grpc",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "http/1.1",
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                "acceptProxyProtocol": true,
                    "serviceName": "gandring"
                }
            }
        },
        {
            "port": 2000,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vless-grpc-nontls
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "grpc",
                "security": "none",
                "serverName": "$domain",
                "grpcSettings": {
                "acceptProxyProtocol": true,
                    "serviceName": "gandring"
                }
            }
        },
        {
            "port": 8888,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vless-hdua-tls
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "h2",
                "security": "tls",
                "tlsSettings": {
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "httpSettings": {
                "acceptProxyProtocol": true,
                    "path": "gandring"
                }
            }
        },
        {
            "port": 20820,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vless-hdua-nontls
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "h2",
                "security": "none",
                "httpSettings": {
                "acceptProxyProtocol": true,
                    "path": "gandring"
                }
            }
        }
    ],
    "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true
    }
  }
}
END

uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat /root/domain)
# // Certificate File
path_crt="/etc/xray/xray.crt"
path_key="/etc/xray/xray.key"
#domain_ecc=$(cat /root/.acme.sh)
#domain.key=$(cat /root/.acme.sh/$domain_ecc)
#path_crt="/root/.acme.sh/$domain_ecc/fullchain.cer"
#path_key="/root/.acme.sh/$domain_ecc/$domain.key"
# Buat Config Xray
cat > /etc/xray/xss.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
  {
      "port": 212,
      "protocol": "shadowsocks",
      "settings": {
        "method": "2022-blake3-aes-128-gcm",
        "password": "gandring",
        "clients": [
          {
            "password": "gandring",
            "email": "gandring@p0x.smule.my.id"
#xray-new-ss
          }
        ],
        "network": "tcp,udp"
      }
    }
  ],
    "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true
    }
  }
}
END
# / / Installation Xray Service
cat > /etc/systemd/system/xray.service << END
[Unit]
Description=XRAY GAJAH DEMAK BY GANDRING
Documentation=https://t.me/zerossl
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# / / Installation Xray Service
cat > /etc/systemd/system/xtrojan.service << END
[Unit]
Description=XTROJAN ROUTING DAM COLO PENGKOL BY ZEROSSL
Documentation=https://t.me/zerossl
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/xtrojan.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# / / Installation Xray Service
cat > /etc/systemd/system/xvless.service << END
[Unit]
Description=XVLESS ROUTING DAM COLO PENGKOL BY ZEROSSL
Documentation=https://t.me/zerossl
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/xvless.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# / / Installation Xray Service
cat > /etc/systemd/system/xss.service << END
[Unit]
Description=XSS ROUTING DAM COLO PENGKOL BY ZEROSSL
Documentation=https://t.me/zerossl
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/xss.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# // Enable & Start Service
# Accept port Xray
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2053 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2052 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2052 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8088 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8088 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2053 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 777 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 777 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2083 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2083 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2096 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2095 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2095 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2096 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 808 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 808 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8808 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8808 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 111 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 111 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 333 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 333 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 888 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 888 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 808 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 808 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 4443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 4443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8888 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8888 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 5443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 5443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 3443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 3443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 888 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 888 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 3443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 3443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 3444 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 3444 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2082 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2082 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

systemctl daemon-reload
systemctl stop xray
systemctl enable xray
systemctl start xray
systemctl restart xray

##restart&start service
systemctl daemon-reload
systemctl enable xtrojan
systemctl stop xtrojan
systemctl start xtrojan
systemctl restart xtrojan

##restart&start service
systemctl daemon-reload
systemctl enable xvless
systemctl stop xvless
systemctl start xvless
systemctl restart xvless

# Install Trojan Go
latest_version="$(curl -s "https://api.github.com/repos/p4gefau1t/trojan-go/releases" | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
trojango_link="https://github.com/p4gefau1t/trojan-go/releases/download/v${latest_version}/trojan-go-linux-amd64.zip"
mkdir -p "/usr/bin/trojan-go"
mkdir -p "/etc/trojan-go"
cd `mktemp -d`
curl -sL "${trojango_link}" -o trojan-go.zip
unzip -q trojan-go.zip && rm -rf trojan-go.zip
mv trojan-go /usr/local/bin/trojan-go
chmod +x /usr/local/bin/trojan-go
mkdir /var/log/trojan-go/
touch /etc/trojan-go/akun.conf
touch /var/log/trojan-go/trojan-go.log

domain=$(cat /root/domain)
# // Certificate File
path_cer="/etc/xray/xray.cer"
path_key="/etc/xray/xray.key"
#domain_ecc=$(cat /root/.acme.sh)
#domain.key=$(cat /root/.acme.sh/$domain_ecc)
#path_crt="/root/.acme.sh/$domain_ecc/fullchain.cer"
#path_key="/root/.acme.sh/$domain_ecc/$domain.key"
# Buat Config Trojan Go
cat > /etc/trojan-go/config.json << END
{
  "run_type": "server",
  "local_addr": "0.0.0.0",
  "local_port": 8880,
  "remote_addr": "127.0.0.1",
  "remote_port": 80,
  "log_level": 1,
  "log_file": "/var/log/trojan-go/trojan-go.log",
  "password": [
      "$uuid"
  ],
  "disable_http_check": true,
  "udp_timeout": 60,
  "ssl": {
    "verify": false,
    "verify_hostname": false,
    "cert": "/etc/xray/xray.crt",
    "key": "/etc/xray/xray.key",
    "key_password": "",
    "cipher": "",
    "curves": "",
    "prefer_server_cipher": false,
    "sni": "$domain",
    "alpn": [
      "http/1.1"
    ],
    "session_ticket": true,
    "reuse_session": true,
    "plain_http_response": "",
    "fallback_addr": "127.0.0.1",
    "fallback_port": 0,
    "fingerprint": "firefox"
  },
  "tcp": {
    "no_delay": true,
    "keep_alive": true,
    "prefer_ipv4": true
  },
  "mux": {
    "enabled": true,
    "concurrency": 8,
    "idle_timeout": 60
  },
  "websocket": {
    "enabled": true,
    "path": "/gandring",
    "host": "$domain"
  },
    "api": {
    "enabled": false,
    "api_addr": "",
    "api_port": 0,
    "ssl": {
      "enabled": false,
      "key": "",
      "cert": "",
      "verify_client": false,
      "client_cert": []
    }
  }
}
END

# Installing Trojan Go Service
cat > /etc/systemd/system/trojan-go.service << END
[Unit]
Description=Trojan-Go BENDUNG COLO PENGKOL BY GANDRING
Documentation=https://t.me/zerossl
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/trojan-go -config /etc/trojan-go/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# Trojan Go Uuid
cat > /etc/trojan-go/uuid.txt << END
$uuid
END

# restart
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8880 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl stop trojan-go
systemctl start trojan-go
systemctl enable trojan-go
systemctl restart trojan-go

cd
cp /root/domain /etc/xray
