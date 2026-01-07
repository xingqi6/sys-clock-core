---
title: System Kernel Sync
emoji: 🕰️
colorFrom: gray
colorTo: black
sdk: docker
app_port: 9787
pinned: false
license: mit
---

# System Clock Synchronization Daemon (v2.6.1-stable)

> **⚠️ RESTRICTED ACCESS**  
> This repository contains the runtime environment for the internal distributed clock synchronization service.  
> Unauthorized modification of the kernel parameters may result in data inconsistency across nodes.

## 📋 System Status
| Service | Status | PID | Port |
| :--- | :--- | :--- | :--- |
| **Kernel Core** | `Active (Running)` | 1 | **9787** |
| **Log Sync** | `Connected` | 102 | - |
| **Watchdog** | `Monitoring` | 24 | - |

---

## ⚙️ Environment Configuration

To configure the runtime parameters, navigate to **Settings** -> **Variables and Secrets**.

### Core Parameters (Required)

| Variable Key | Description | Recommended Value |
| :--- | :--- | :--- |
| `AUTH_PASSWORD` | **Root Access Token**. Used for secure dashboard authentication. | *(High Entropy String)* |
| `TZ` | System Timezone. Critical for accurate Cron triggers. | `Asia/Shanghai` |
| `CRON_SCHEDULE` | Routine Check Frequency (Cron Syntax). | `0,30 * * * *` |

### Remote Storage (Persistence)

This service supports **WebDAV** for state serialization. If configured, snapshots are automatically pushed to the remote endpoint.

| Variable Key | Description |
| :--- | :--- |
| `WEBDAV_URL` | Remote storage endpoint URL. |
| `WEBDAV_USERNAME` | Storage authentication identity. |
| `WEBDAV_PASSWORD` | Storage authentication secret. |
| `WEBDAV_BACKUP_PATH` | Directory for storing system snapshots (e.g., `sys_logs`). |
| `SYNC_INTERVAL` | Backup interval in seconds (Default: 3600). |

---

## 🔐 Operation Manual

### 1. Initialization
The daemon will automatically attempt to pull the latest system state from the configured `WEBDAV_URL` upon boot. If no remote state is found, it initializes a clean kernel.

### 2. Dashboard Access
Access the management interface via the exposed Service Port (**9787**).  
Use the `AUTH_PASSWORD` to authorize the session.

### 3. Data Integrity
*   **Auto-Save**: System state is serialized to `tar.gz` format every `SYNC_INTERVAL`.
*   **Retention**: To conserve storage, only the **latest 5 snapshots** are retained on the remote server.

---
