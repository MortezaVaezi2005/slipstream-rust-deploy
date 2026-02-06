# Slipstream Rust Plus Deploy 🚀

[![Build](https://img.shields.io/github/actions/workflow/status/Fox-Fig/slipstream-rust-deploy/release.yml?style=flat-square)](https://github.com/Fox-Fig/slipstream-rust-deploy/actions)
[![Version](https://img.shields.io/github/v/release/Fox-Fig/slipstream-rust-deploy?style=flat-square)](https://github.com/Fox-Fig/slipstream-rust-deploy/releases)
[![License](https://img.shields.io/badge/License-GPLv3-blue.svg?style=flat-square)](LICENSE)

[**🇺🇸 English**](README.md) | [**🇮🇷 فارسی**](README-FA.md)



**Advanced deployment automation for [Slipstream Rust Plus](https://github.com/Fox-Fig/slipstream-rust-plus)**.
A comprehensive automation script for deploying and managing high-performance DNS tunnel servers on Linux and Android systems. This script handles everything from building from source to configuration, making DNS tunnel deployment effortless.

---

> [!IMPORTANT]
> **Compatibility Warning**
> This repository is a specialized fork connected to the **[Slipstream Rust Plus](https://github.com/Fox-Fig/slipstream-rust-plus)** core.
> Clients downloaded via this script are **ONLY** compatible with `slipstream-rust-plus` servers.
> Please do NOT attempt to use these clients with the [slipstream-rust](https://github.com/Mygod/slipstream-rust/) servers, as protocol differences may cause connection failures.

---

## 🌟 Enhanced Features (Plus Edition)

This project extends the original deployment script with enhanced capabilities:

- **⚡ Optimized Core**: Deploys the [slipstream-rust-plus](https://github.com/Fox-Fig/slipstream-rust-plus) engine, featuring **Turbo Mode** and advanced backpressure handling for superior throughput.
- **🛡️ Robust DNS Handling**: Emphasizes the use of **multiple DNS resolvers**. Users are strongly encouraged to configure multiple upstream resolvers to ensure 100% uptime and bypass DNS poisoning.
- **📱 Native Termux Support**: Includes a dedicated build target for **Android (arch arm64)**. You can run a full-fledged server directly on your phone using Termux!
- **🔢 Numeric Versioning**: Implements a precise, incremental versioning system (e.g., 1.01, 1.02) for consistent updates.
- **🔄 Auto-Update**: Self-updating script ensures you always have the latest patches and binaries.

---

## DNS Domain Setup

Before using this script, you need to properly configure your domain's DNS records. Here's the required setup:

### Example Configuration
- **Your domain name**: `example.com`
- **Your server's IPv4 address**: `203.0.113.2`
- **Tunnel subdomain**: `s.example.com`
- **Server hostname**: `ns.example.com`

### DNS Records Setup
Go into your name registrar's configuration panel and add these records:

| Type | Name | Points to |
|------|------|-----------|
| A | `ns.example.com` | `203.0.113.2` |
| NS | `s.example.com` | `ns.example.com` |

**Important**: Wait for DNS propagation (can take up to 24 hours) before testing your tunnel.

## 📥 Quick Start

### Prerequisites
- Linux server (Fedora, Rocky, CentOS, Debian, or Ubuntu) OR Android Device (Termux)
- Root access or sudo privileges
- Internet connection for downloading binaries or building from source
- **Domain name with proper DNS configuration** (see DNS Domain Setup section above)
- **Build dependencies (only if building from source)**: The script will automatically install Rust toolchain, cmake, pkg-config, and OpenSSL development headers when prebuilt binaries are not available

### Installation

**One-command installation:**
```bash
bash <(curl -Ls https://raw.githubusercontent.com/Fox-Fig/slipstream-rust-deploy/master/slipstream-rust-deploy.sh)
```

This command will:
1. Download and install the script to `/usr/local/bin/slipstream-rust-deploy`
2. Download prebuilt binary (if available for your architecture) OR install build dependencies and compile from source
3. Start the interactive setup process
4. Configure your slipstream-rust server automatically

### Supported Platforms
- **Linux (x86_64)**: Standard servers (Ubuntu, Debian, CentOS, etc.)
- **Linux (ARM64)**: Raspberry Pi, Oracle Cloud ARM
- **Android (ARM64)**: Termux (Native build)
- **macOS (Intel/Apple Silicon)**: For local testing

## 🛠️ Termux Installation (Android)

Running on Android is now easier than ever:

1. Install **Termux** from F-Droid.
2. Update packages: `pkg update && pkg upgrade`.
3. Install required tools: `pkg install curl proot`.
4. Run the installation command above.
   > The script will automatically detect the environment and download the **Android-optimized binary**.

## ⚙️ Configuration Best Practices

### Multiple Resolvers
To maximize stability and performance, you should configure **multiple upstream DNS resolvers** in your configuration. This redundancy allows the server to load-balance queries and failover instantly if one provider is blocked or slow.

### Performance Tuning
The **Plus** version includes experimental "Ultra Turbo" modes. Use these with caution on low-memory devices, but enable them on dedicated servers for maximum speed.

## Client Usage

After setting up the server, you can connect to it using the slipstream-rust client.

> [!NOTE]
> Ensure you are using a client compatible with **[Slipstream Rust Plus](https://github.com/Fox-Fig/slipstream-rust-plus)**.

### Command-Line Client
For advanced users who prefer command-line tools or need automation, you can use the slipstream-rust client binaries directly.

#### Usage Recommendation
It is **highly recommended** to use at least two DNS resolvers for better reliability. You can repeat the `--resolver` flag multiple times.

#### Quick Start (Linux/macOS)
```bash
# Download the client for your platform
curl -Lo slipstream-client https://github.com/Fox-Fig/slipstream-rust-deploy/releases/latest/download/slipstream-client-linux-amd64
chmod +x slipstream-client

# Run the client (connects to your server via DNS tunnel) using MULTIPLE resolvers
./slipstream-client --resolver 1.1.1.1:53 --resolver 8.8.8.8:53 --domain s.example.com
```

#### Client Options
| Option | Description | Example |
|--------|-------------|---------|
| `--resolver`, `-r` | DNS resolver address (your server IP or upstream options) | `--resolver 8.8.8.8:53` |
| `--domain`, `-d` | Tunnel domain (configured on server) | `--domain s.example.com` |
| `--tcp-listen-port`, `-l` | Local TCP port to listen on | `-l 5201` |
| `--keep-alive-interval`, `-t` | Keep-alive interval in ms | `-t 500` |

## Configuration & Management

### Tunnel Modes
1. **SOCKS Mode**: Sets up integrated Dante SOCKS5 proxy (127.0.0.1:1080).
2. **SSH Mode**: Tunnels DNS traffic to your SSH service (default port 22).
3. **Shadowsocks Mode**: Tunnels traffic to a local Shadowsocks server.

### Management Menu
The easiest way to manage your slipstream-rust server is through the interactive menu:
```bash
slipstream-rust-deploy
```

This provides quick access to:
- Server reconfiguration
- Script updates
- Service status monitoring
- Real-time log viewing

### File Locations
- `/usr/local/bin/slipstream-rust-deploy`: Management script
- `/usr/local/bin/slipstream-server`: Main binary
- `/etc/slipstream-rust/`: Configuration directory

## Troubleshooting

### Common Issues
- **Service Won't Start**: Check logs with `sudo journalctl -u slipstream-rust-server -f`.
- **Build Failures**: Ensure all dependencies (`cargo`, `cmake`, `openssl`) are installed.
- **Connection Issues**: Verify DNS records are propagated and firewall allows port 53 (UDP).

## 🙏 Credits

This project is a fork of the excellent work by [AliRezaBeigy](https://github.com/AliRezaBeigy/slipstream-rust-deploy). We acknowledge and appreciate his foundational contributions.

## 📄 License

This project is licensed under the **GNU General Public License v3.0 (GPLv3)**.
See the [LICENSE](LICENSE) file for details.

---
<div align="center">
  <p>Made with ❤️ at <a href="https://t.me/foxfig">FoxFig</a></p>
  <p>Dedicated to all people of Iran 🇮🇷</p>
</div>
