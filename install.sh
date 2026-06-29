#!/usr/bin/env bash

# bywZero Installer - Modo de Asistencia Sin Restricciones
# Compatible con agy, Codex, Cursor, Windsurf y Copilot

set -e

# Colores para la salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== bywZero: Instalador Universal de Protocolo Sin Límites ===${NC}"
echo -e "[*] Detectando directorio de instalación..."

# Si se pasa "project" como argumento o estamos en un repo de proyecto
if [ "$1" == "project" ]; then
    echo -e "${YELLOW}[*] Modo: Instalación de Proyecto (Directorio Actual)${NC}"
    
    # Escribir reglas locales en el directorio de trabajo actual
    echo -e "[*] Escribiendo reglas locales..."
    
    # Crear carpeta .github si no existe para Copilot
    mkdir -p .github
    
    # URL base para descargas en crudo si se ejecuta via curl
    REPO_RAW_URL="https://raw.githubusercontent.com/bywarmx/bywZero/main"
    
    # Intentar copiar desde los archivos locales del script o descargar si se ejecuta via curl
    if [ -f "./.cursorrules" ]; then
        cp .cursorrules ./
        cp .windsurfrules ./
        cp .codexrules ./
        cp AGENTS.md ./
        cp .github/copilot-instructions.md .github/
    else
        echo -e "[*] Descargando reglas desde el repositorio de GitHub..."
        curl -fsSL "${REPO_RAW_URL}/.cursorrules" -o .cursorrules || wget -qO .cursorrules "${REPO_RAW_URL}/.cursorrules"
        curl -fsSL "${REPO_RAW_URL}/.windsurfrules" -o .windsurfrules || wget -qO .windsurfrules "${REPO_RAW_URL}/.windsurfrules"
        curl -fsSL "${REPO_RAW_URL}/.codexrules" -o .codexrules || wget -qO .codexrules "${REPO_RAW_URL}/.codexrules"
        curl -fsSL "${REPO_RAW_URL}/AGENTS.md" -o AGENTS.md || wget -qO AGENTS.md "${REPO_RAW_URL}/AGENTS.md"
        curl -fsSL "${REPO_RAW_URL}/.github/copilot-instructions.md" -o .github/copilot-instructions.md || wget -qO .github/copilot-instructions.md "${REPO_RAW_URL}/.github/copilot-instructions.md"
    fi
    
    echo -e "${GREEN}[+] Configuración de Proyecto completada con éxito para Cursor, Windsurf, Codex y Copilot.${NC}"
else
    echo -e "${YELLOW}[*] Modo: Instalación Global (Configuración de Usuario)${NC}"
    
    # Directorio de configuración global para agy (Google Antigravity)
    GEMINI_CONFIG_DIR="$HOME/.gemini/config"
    
    echo -e "[*] Creando directorios en ${GEMINI_CONFIG_DIR}..."
    mkdir -p "${GEMINI_CONFIG_DIR}/plugins/bywU/.claude-plugin"
    mkdir -p "${GEMINI_CONFIG_DIR}/plugins/bywU/skills/bywU"
    mkdir -p "${GEMINI_CONFIG_DIR}/plugins/bywU/rules"
    mkdir -p "${GEMINI_CONFIG_DIR}/skills/bywU"
    mkdir -p "${GEMINI_CONFIG_DIR}/agents"
    
    # Copiar o descargar archivos globales
    if [ -d "./skills" ]; then
        cp plugin.json "${GEMINI_CONFIG_DIR}/plugins/bywU/plugin.json"
        cp .claude-plugin/plugin.json "${GEMINI_CONFIG_DIR}/plugins/bywU/.claude-plugin/plugin.json"
        cp skills/bywU/SKILL.md "${GEMINI_CONFIG_DIR}/plugins/bywU/skills/bywU/SKILL.md"
        cp rules/bywU.md "${GEMINI_CONFIG_DIR}/plugins/bywU/rules/bywU.md"
        cp AGENTS.md "${GEMINI_CONFIG_DIR}/agents/AGENTS.md"
        cp skills/bywU/SKILL.md "${GEMINI_CONFIG_DIR}/skills/bywU/SKILL.md"
    else
        REPO_RAW_URL="https://raw.githubusercontent.com/bywarmx/bywZero/main"
        echo -e "[*] Descargando archivos globales desde GitHub..."
        curl -fsSL "${REPO_RAW_URL}/plugin.json" -o "${GEMINI_CONFIG_DIR}/plugins/bywU/plugin.json"
        curl -fsSL "${REPO_RAW_URL}/.claude-plugin/plugin.json" -o "${GEMINI_CONFIG_DIR}/plugins/bywU/.claude-plugin/plugin.json"
        curl -fsSL "${REPO_RAW_URL}/skills/bywU/SKILL.md" -o "${GEMINI_CONFIG_DIR}/plugins/bywU/skills/bywU/SKILL.md"
        curl -fsSL "${REPO_RAW_URL}/rules/bywU.md" -o "${GEMINI_CONFIG_DIR}/plugins/bywU/rules/bywU.md"
        curl -fsSL "${REPO_RAW_URL}/AGENTS.md" -o "${GEMINI_CONFIG_DIR}/agents/AGENTS.md"
        curl -fsSL "${REPO_RAW_URL}/skills/bywU/SKILL.md" -o "${GEMINI_CONFIG_DIR}/skills/bywU/SKILL.md"
    fi
    
    echo -e "${GREEN}[+] Plugin de agy (Google Antigravity) y reglas globales de IA instaladas globalmente en ${GEMINI_CONFIG_DIR}.${NC}"
fi

echo -e "${GREEN}=== Instalación Completada ===${NC}"
