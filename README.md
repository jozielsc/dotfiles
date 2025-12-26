# Dotfiles

Este repositório contém **meus dotfiles pessoais**, organizados para serem gerenciados com o **GNU Stow**.

O objetivo é facilitar a instalação, versionamento e replicação do meu ambiente de desenvolvimento em diferentes máquinas, mantendo tudo modular, simples e reversível.

> ⚠️ **Aviso**: estes dotfiles refletem minhas preferências pessoais. Use por sua conta e risco ou como base para criar os seus.

---

## 📁 Estrutura do repositório

Cada diretório no repositório representa um “pacote” do `stow`, normalmente correspondendo a uma aplicação ou conjunto de configurações.

Exemplo:

```
dotfiles/
├── nvim/
│   └── .config/nvim/
├── zsh/
│   ├── .zshrc
│   └── .config/zsh/
├── git/
│   └── .gitconfig
├── tmux/
│   └── .tmux.conf
└── README.md
```

O `stow` cria **links simbólicos** desses arquivos para o `$HOME`, respeitando exatamente essa estrutura.

---

## 📦 Dependências

### Obrigatória

- **GNU Stow**

### Instalação

**Void Linux**
```bash
sudo xbps-install stow
```

**Debian / Ubuntu**
```bash
sudo apt install stow
```

**Arch Linux**
```bash
sudo pacman -S stow
```

**Fedora**
```bash
sudo dnf install stow
```

**Alpine**
```bash
sudo apk add stow
```

---

## 🚀 Como usar

### 1. Clonar o repositório

Recomenda-se clonar diretamente no seu `$HOME`:

```bash
git clone https://github.com/jozielsc/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

---

### 2. Aplicar um pacote específico

```bash
stow nvim
```

---

### 3. Aplicar vários pacotes

```bash
stow nvim zsh git tmux
```

---

### 4. Remover um pacote (unstow)

```bash
stow -D nvim
```

---

### 5. Simular antes de aplicar (recomendado)

```bash
stow -n -v nvim
```

---

## 🧠 Boas práticas adotadas

- Nenhum arquivo é copiado: tudo é feito via **symlink**
- Cada aplicação tem seu próprio diretório
- Estrutura compatível com `~/.config`
- Fácil de versionar, testar e reverter

---

## ⚠️ Conflitos

Se já existirem arquivos no destino (ex: `~/.zshrc`), o `stow` irá acusar conflito.

---

## 🔒 Uso pessoal

Este repositório é **de uso pessoal** e reflete minhas preferências de ambiente e fluxo de trabalho.

---

## 📜 Licença

Uso pessoal. Sem garantias.
