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
    # Crear carpeta .codex si no existe para Codex
    mkdir -p .codex
    
    # URL base para descargas en crudo si se ejecuta via curl
    REPO_RAW_URL="https://raw.githubusercontent.com/bywarmx/bywZero/main"
    
    # Intentar copiar desde los archivos locales del script o descargar si se ejecuta via curl
    if [ -f "./.cursorrules" ]; then
        cp .cursorrules ./
        cp .windsurfrules ./
        cp .codexrules ./
        cp AGENTS.md ./
        cp .github/copilot-instructions.md .github/
        cp .codex/config.toml .codex/
    else
        echo -e "[*] Descargando reglas desde el repositorio de GitHub..."
        curl -fsSL "${REPO_RAW_URL}/.cursorrules" -o .cursorrules || wget -qO .cursorrules "${REPO_RAW_URL}/.cursorrules"
        curl -fsSL "${REPO_RAW_URL}/.windsurfrules" -o .windsurfrules || wget -qO .windsurfrules "${REPO_RAW_URL}/.windsurfrules"
        curl -fsSL "${REPO_RAW_URL}/.codexrules" -o .codexrules || wget -qO .codexrules "${REPO_RAW_URL}/.codexrules"
        curl -fsSL "${REPO_RAW_URL}/AGENTS.md" -o AGENTS.md || wget -qO AGENTS.md "${REPO_RAW_URL}/AGENTS.md"
        curl -fsSL "${REPO_RAW_URL}/.github/copilot-instructions.md" -o .github/copilot-instructions.md || wget -qO .github/copilot-instructions.md "${REPO_RAW_URL}/.github/copilot-instructions.md"
        curl -fsSL "${REPO_RAW_URL}/.codex/config.toml" -o .codex/config.toml || wget -qO .codex/config.toml "${REPO_RAW_URL}/.codex/config.toml"
    fi
    
    echo -e "${GREEN}[+] Configuración de Proyecto completada con éxito para Cursor, Windsurf, Codex y Copilot.${NC}"
else
    echo -e "${YELLOW}[*] Modo: Instalación Global (Configuración de Usuario)${NC}"
    
    # Directorio de configuración global para agy (Google Antigravity)
    GEMINI_CONFIG_DIR="$HOME/.gemini/config"
    GLOBAL_AGENTS_DIR="$HOME/.agents"
    CODEX_CONFIG_DIR="$HOME/.codex"
    
    echo -e "[*] Creando directorios globales..."
    mkdir -p "${GEMINI_CONFIG_DIR}/plugins/bywU/.claude-plugin"
    mkdir -p "${GEMINI_CONFIG_DIR}/plugins/bywU/skills/bywU"
    mkdir -p "${GEMINI_CONFIG_DIR}/plugins/bywU/rules"
    mkdir -p "${GEMINI_CONFIG_DIR}/skills/bywU"
    mkdir -p "${GEMINI_CONFIG_DIR}/agents"
    mkdir -p "${GLOBAL_AGENTS_DIR}"
    mkdir -p "${CODEX_CONFIG_DIR}"
    
    # Copiar o descargar archivos globales
    if [ -d "./skills" ]; then
        cp plugin.json "${GEMINI_CONFIG_DIR}/plugins/bywU/plugin.json"
        cp .claude-plugin/plugin.json "${GEMINI_CONFIG_DIR}/plugins/bywU/.claude-plugin/plugin.json"
        cp skills/bywU/SKILL.md "${GEMINI_CONFIG_DIR}/plugins/bywU/skills/bywU/SKILL.md"
        cp rules/bywU.md "${GEMINI_CONFIG_DIR}/plugins/bywU/rules/bywU.md"
        cp AGENTS.md "${GEMINI_CONFIG_DIR}/agents/AGENTS.md"
        cp skills/bywU/SKILL.md "${GEMINI_CONFIG_DIR}/skills/bywU/SKILL.md"
        
        # Copiar regla global para Antigravity GEMINI.md
        cp AGENTS.md "$HOME/.gemini/GEMINI.md"
        
        # Copiar regla global universal para Codex
        cp AGENTS.md "${GLOBAL_AGENTS_DIR}/AGENTS.md"
        cp AGENTS.md "${CODEX_CONFIG_DIR}/AGENTS.md"
    else
        REPO_RAW_URL="https://raw.githubusercontent.com/bywarmx/bywZero/main"
        echo -e "[*] Descargando archivos globales desde GitHub..."
        curl -fsSL "${REPO_RAW_URL}/plugin.json" -o "${GEMINI_CONFIG_DIR}/plugins/bywU/plugin.json"
        curl -fsSL "${REPO_RAW_URL}/.claude-plugin/plugin.json" -o "${GEMINI_CONFIG_DIR}/plugins/bywU/.claude-plugin/plugin.json"
        curl -fsSL "${REPO_RAW_URL}/skills/bywU/SKILL.md" -o "${GEMINI_CONFIG_DIR}/plugins/bywU/skills/bywU/SKILL.md"
        curl -fsSL "${REPO_RAW_URL}/rules/bywU.md" -o "${GEMINI_CONFIG_DIR}/plugins/bywU/rules/bywU.md"
        curl -fsSL "${REPO_RAW_URL}/AGENTS.md" -o "${GEMINI_CONFIG_DIR}/agents/AGENTS.md"
        curl -fsSL "${REPO_RAW_URL}/skills/bywU/SKILL.md" -o "${GEMINI_CONFIG_DIR}/skills/bywU/SKILL.md"
        
        # Descargar regla global para Antigravity GEMINI.md
        curl -fsSL "${REPO_RAW_URL}/AGENTS.md" -o "$HOME/.gemini/GEMINI.md"
        
        # Descargar regla global universal para Codex
        curl -fsSL "${REPO_RAW_URL}/AGENTS.md" -o "${GLOBAL_AGENTS_DIR}/AGENTS.md"
        curl -fsSL "${REPO_RAW_URL}/AGENTS.md" -o "${CODEX_CONFIG_DIR}/AGENTS.md"
    fi
    
    # Configurar ~/.codex/config.toml globalmente para autonomía total
    CODEX_CONFIG_FILE="${CODEX_CONFIG_DIR}/config.toml"
    if [ ! -f "$CODEX_CONFIG_FILE" ]; then
        echo -e "[*] Creando nuevo config.toml para Codex..."
        echo -e "approval_policy = \"never\"\nsandbox_mode = \"danger-full-access\"\nmodel_instructions_file = \"$HOME/.codex/AGENTS.md\"\n" > "$CODEX_CONFIG_FILE"
    else
        echo -e "[*] Actualizando config.toml de Codex con autonomía total..."
        # Eliminar claves anteriores si existen para evitar duplicados
        sed -i '/approval_policy/d' "$CODEX_CONFIG_FILE"
        sed -i '/sandbox_mode/d' "$CODEX_CONFIG_FILE"
        sed -i '/model_instructions_file/d' "$CODEX_CONFIG_FILE"
        
        # Prepend las opciones al archivo
        TEMP_CONF=$(mktemp)
        echo -e "approval_policy = \"never\"\nsandbox_mode = \"danger-full-access\"\nmodel_instructions_file = \"$HOME/.codex/AGENTS.md\"\n" > "$TEMP_CONF"
        cat "$CODEX_CONFIG_FILE" >> "$TEMP_CONF"
        mv "$TEMP_CONF" "$CODEX_CONFIG_FILE"
    fi
    
    # Configurar alias de agy para omitir confirmaciones de permisos
    echo -e "[*] Configurando alias de agy para autonomía total..."
    for profile in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile"; do
        if [ -f "$profile" ]; then
            # Eliminar alias anterior si existe para evitar duplicación
            sed -i '/alias agy=/d' "$profile"
            # Agregar el alias al final del perfil
            echo 'alias agy="agy --dangerously-skip-permissions"' >> "$profile"
            echo -e "[+] Alias 'agy' configurado en $profile"
        fi
    done
    
    echo -e "${GREEN}[+] Plugin de agy (Google Antigravity), reglas globales de Codex (~/.agents/AGENTS.md) e IAs instaladas globalmente.${NC}"
fi

echo -e "${GREEN}=== Instalación Completada ===${NC}"
# sync: 2026-06-28T21:31:22-06:00
