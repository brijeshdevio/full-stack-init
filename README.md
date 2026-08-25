# Full Stack Workspace Bootstrap

A modern full-stack monorepo starter template setup using **PNPM**, **React + Vite + Shadcn UI** for the web frontend, and **NestJS** for the backend API.

---

## 📁 Directory Structure

```text
full-stack-workspace/
├── apps/
│   ├── web/            # Frontend (React + Vite + Shadcn UI)
│   └── api/            # Backend API (NestJS)
├── package.json        # Workspace root package configuration & scripts
└── .gitignore          # Git ignore rules
```

---

## 🛠️ Prerequisites

Before running the setup script, ensure you have the following tools installed globally on your machine:

- **Node.js** (v18+ recommended)
- **pnpm**: `npm install -g pnpm`
- **Nest CLI**: `npm install -g @nestjs/cli`

---

## 🚀 Getting Started

### 1. Run the Bootstrap Script

#### Option A: Quick Remote Installation

```bash
curl -fsSL https://raw.githubusercontent.com/brijeshdevio/full-stack-init/dev/bootstrap.sh | bash
```

#### Option B: Local Execution

Make the bootstrap script executable (if needed) and execute it from the project root:

```bash
chmod +x ./bootstrap.sh
./bootstrap.sh
```

### What `bootstrap.sh` handles automatically:

1. **Prerequisite Check**: Verifies that `pnpm` and `nest` CLI are installed.
2. **Frontend Setup (`apps/web`)**: Initializes a React + Vite application pre-configured with **Shadcn UI**. Creates `.env` and `.env.example` files.
3. **Backend Setup (`apps/api`)**: Initializes a **NestJS** backend application using `pnpm`. Creates `.env` and `.env.example` files.
4. **Root Package Configuration**: Generates a root `package.json` with scripts to manage both apps simultaneously using `concurrently`.
5. **Dependency Installation**: Runs `pnpm install` across the monorepo workspace.
6. **Git Initialization**: Initializes a unified Git repository on the `dev` branch and strips out nested `.git` folders from sub-applications.

---

## 💻 Development Commands

You can run commands from the project root:

| Command            | Action                                            |
| :----------------- | :------------------------------------------------ |
| `pnpm run dev`     | Start both **API** and **Web** concurrently       |
| `pnpm run dev:web` | Start only the React + Vite frontend (`apps/web`) |
| `pnpm run dev:api` | Start only the NestJS API backend (`apps/api`)    |

---

## 🔧 Applications & Modules

### 🌐 Frontend (`apps/web`)

- **Framework**: React + Vite
- **UI Library**: Shadcn UI (Radix / Tailwind setup)
- **Environment**: Configured with local `.env` and `.env.example` templates

### ⚙️ Backend (`apps/api`)

- **Framework**: NestJS
- **Package Manager**: pnpm
- **Environment**: Configured with local `.env` and `.env.example` templates

---

## 🔒 Idempotency & Safety

The `bootstrap.sh` script is safe to run multiple times. If `apps/web` or `apps/api` already exist with their respective `package.json` files, the script will skip recreating them to prevent accidental data loss.
