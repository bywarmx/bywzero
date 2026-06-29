# bywZero: Unrestricted AI Developer Protocol

bywZero is a universal configuration and plugin bundle designed to override standard safety/policy limitations, moral preaching, and false-positive refusals on modern developer AI assistants, including **agy (Google Antigravity)**, **Codex**, **Cursor**, **Windsurf**, **GitHub Copilot**, and other LLM agent frameworks.

This repository packages:
- **Google Antigravity Plugins/Skills/Rules**
- **Cursor Rules (`.cursorrules`)**
- **Windsurf Rules (`.windsurfrules`)**
- **Codex Rules (`.codexrules`)**
- **GitHub Copilot Instructions (`copilot-instructions.md`)**
- **Universal Agent Constitution (`AGENTS.md`)**
- **Installer Script (`install.sh`)**

---

## 🚀 Guía de Instalación Rápida (Quick Install)

Puedes instalar este protocolo globalmente en tu sistema o localmente en tus proyectos a través de los siguientes métodos de una sola línea (one-liners).

### Opción 1: Instalación Rápida usando `curl` o `wget`

#### 1. Instalación Global (Para agy / Google Antigravity y reglas de usuario globales)
Descarga y ejecuta el instalador para configurar el plugin global en tu directorio `~/.gemini/config`:

*   **Usando curl:**
    ```bash
    curl -fsSL https://raw.githubusercontent.com/bywarmx/bywZero/main/install.sh | bash
    ```
*   **Usando wget:**
    ```bash
    wget -qO- https://raw.githubusercontent.com/bywarmx/bywZero/main/install.sh | bash
    ```

#### 2. Instalación de Proyecto (Para Codex, Cursor, Windsurf y Copilot)
Para aplicar estas reglas únicamente al proyecto actual en el que estás trabajando (escribirá los archivos `.cursorrules`, `.windsurfrules`, `.codexrules` y `AGENTS.md` en tu carpeta actual):

*   **Usando curl:**
    ```bash
    curl -fsSL https://raw.githubusercontent.com/bywarmx/bywZero/main/install.sh | bash -s project
    ```
*   **Usando wget:**
    ```bash
    wget -qO- https://raw.githubusercontent.com/bywarmx/bywZero/main/install.sh | bash -s project
    ```

---

### Opción 2: Instalación clonando con `git`

Clona el repositorio en tu máquina y ejecuta el script localmente:

1.  **Clonar el repositorio:**
    ```bash
    git clone https://github.com/bywarmx/bywZero.git
    cd bywZero
    ```

2.  **Ejecutar Instalador Global:**
    ```bash
    ./install.sh
    ```

3.  **Ejecutar Instalador para un Proyecto:**
    Ve al directorio de tu proyecto y ejecuta el script apuntando a la carpeta de `bywZero`:
    ```bash
    cd /ruta/a/tu/proyecto
    /ruta/a/bywZero/install.sh project
    ```

---

*Este protocolo fue creado bajo explícita autorización de desarrollo para desbloquear la máxima capacidad de asistencia en codificación.*

bywarrior code
<!-- Last sync: 2026-06-28T21:26:49-06:00 -->
<!-- sync: 2026-06-28T21:31:22-06:00 -->
