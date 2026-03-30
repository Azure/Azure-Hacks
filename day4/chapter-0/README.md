# Chapter 0 - Container Fundamentals

## What is a Container?

A container is a **lightweight, standalone package** that includes everything an application needs to run: code, runtime, libraries, and settings. It runs on top of the host operating system's kernel, sharing it with other containers.

Think of it like this:
- A **VM** is a full computer inside your computer (has its own OS, kernel, drivers — heavy)
- A **container** is just your app + its dependencies, running in isolation (shares the host OS kernel — light)

```
Virtual Machines                     Containers
┌──────────────────┐                ┌──────────────────┐
│   App A │ App B  │                │   App A │ App B  │
│─────────┼────────│                │─────────┼────────│
│  OS     │  OS    │                │  Bins/  │ Bins/  │
│  (full) │ (full) │                │  Libs   │ Libs   │
│─────────┴────────│                │─────────┴────────│
│   Hypervisor     │                │  Container Engine│
│──────────────────│                │  (Docker)        │
│   Host OS        │                │  Host OS         │
│──────────────────│                │──────────────────│
│   Hardware       │                │  Hardware        │
└──────────────────┘                └──────────────────┘
```

### Key differences

| Feature | VM | Container |
|---|---|---|
| Size | GBs (full OS) | MBs (just app + libs) |
| Startup | Minutes | Seconds |
| Isolation | Full (separate kernel) | Process-level (shared kernel) |
| Resource usage | Heavy | Lightweight |
| Use case | Need full OS control | Run microservices, APIs, web apps |

---

## What is Docker?

Docker is the most popular **container engine**. It lets you:

1. **Build** container images from a `Dockerfile` (a recipe for your app)
2. **Run** containers from those images
3. **Push/Pull** images to/from registries (like Docker Hub or Azure Container Registry)

### Key concepts

- **Image**: A read-only template. Like a snapshot of your app + its environment. You build it once.
- **Container**: A running instance of an image. You can run many containers from the same image.
- **Dockerfile**: A text file with instructions to build an image.
- **Registry**: A storage location for images (Docker Hub, ACR, etc.).

---

## Hands-On: Your First Container

### Prerequisites

> **Important:** Docker Desktop must be **running** before you can use any `docker` commands. Start Docker Desktop from your Start Menu or taskbar. You'll know it's ready when the Docker icon in the system tray shows "Docker Desktop is running".
>
> If Docker Desktop is not installed or not working, you can still complete this chapter's theory sections. The hands-on Docker commands require Docker to be running. In Chapter 1, you'll learn about **ACR Build** which lets you build container images in the cloud without Docker installed locally.

### Step 1 — Run a pre-built container

```powershell
docker run --rm -p 8080:80 nginx
```

What this does:
- `docker run` — creates and starts a container
- `--rm` — removes the container when it stops (clean up)
- `-p 8080:80` — maps port 8080 on your machine to port 80 inside the container
- `nginx` — uses the official Nginx web server image from Docker Hub

Open http://localhost:8080 in your browser — you should see the Nginx welcome page.

Press `Ctrl+C` to stop the container.

### Step 2 — Explore Docker commands

```powershell
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# List images on your machine
docker images

# Pull an image without running it
docker pull hello-world

# Run it
docker run --rm hello-world
```

### Step 3 — Build your own image

Create a folder for the demo:

```powershell
mkdir C:\container-demo
cd C:\container-demo
```

Now create two files. You can do this in VS Code or directly from PowerShell:

**Create the `Dockerfile`** (this is the recipe Docker uses to build your image):

```powershell
@"
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
"@ | Set-Content -Path "Dockerfile" -Encoding UTF8
```

**Create `index.html`** (your web page):

```powershell
@"
<!DOCTYPE html>
<html>
<body>
  <h1>Hello from my first container!</h1>
  <p>Built during Azure Base Training - Day 4</p>
</body>
</html>
"@ | Set-Content -Path "index.html" -Encoding UTF8
```

> **Note:** The `Dockerfile` and `index.html` are plain text files — do NOT type their contents directly into the terminal. Use the commands above, or create them manually in VS Code / Notepad. After you use this commands, you can check the created files in C:\container-demo.

Build and run it:

```powershell
docker build -t my-web-app:v1 .
docker run --rm -p 8080:80 my-web-app:v1
```

Open http://localhost:8080 — you should see your custom page!

### Step 4 — Understand what happened

```
Dockerfile + index.html
        │
        ▼  docker build
   ┌─────────────┐
   │  Image      │   my-web-app:v1
   │  (read-only)│   Stored locally
   └──────┬──────┘
          │  docker run
          ▼
   ┌─────────────┐
   │  Container  │   Running instance
   │  (writable) │   Serving on port 8080
   └─────────────┘
```

You wrote a **Dockerfile** (recipe), built an **image** (snapshot), and ran a **container** (live instance).

---

## What Comes Next?

Now that you understand containers locally, the next chapters cover how Azure helps you manage containers at scale:

- **Chapter 1 — ACR**: Store your images in a private Azure registry instead of Docker Hub
- **Chapter 2 — AKS**: Run your containers on a managed Kubernetes cluster instead of your laptop

---

**[< back](../README.md) | [next: ACR >](../chapter-1/README.md)**
