#!/bin/bash

# Phase 1.1 Flask Tutorial - Arch Linux Setup Script
# This script automates the initial setup for Arch Linux users

echo "🐧 Phase 1.1 Flask Tutorial - Arch Linux Setup"
echo "=============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    print_error "This script is designed for Arch Linux systems with pacman package manager."
    exit 1
fi

print_status "Updating system packages..."
sudo pacman -Syu --noconfirm

print_status "Installing Python and development tools..."
sudo pacman -S --needed --noconfirm python python-pip python-virtualenv

# Optional: Install additional development tools
print_status "Installing optional development tools..."
sudo pacman -S --needed --noconfirm git tree curl wget

print_status "Creating virtual environment..."
if [ -d "flask_env" ]; then
    print_warning "Virtual environment already exists. Skipping creation."
else
    python -m venv flask_env
    print_status "Virtual environment created successfully."
fi

print_status "Activating virtual environment..."
source flask_env/bin/activate

print_status "Upgrading pip..."
pip install --upgrade pip

print_status "Installing Flask dependencies..."
pip install flask flask-wtf email-validator python-dotenv flask-debugtoolbar

print_status "Creating project structure..."
# Create directories
mkdir -p app/templates
mkdir -p static/{css,js}

print_status "Creating requirements.txt..."
cat > requirements.txt << 'EOF'
# Core Flask dependencies
Flask==3.0.0
Flask-WTF==1.2.1
email-validator==2.1.0
python-dotenv==1.0.0
WTForms==3.1.1

# Optional development dependencies
flask-debugtoolbar==0.13.1
EOF

print_status "Creating .env file..."
if [ ! -f ".env" ]; then
    cat > .env << 'EOF'
SECRET_KEY=your-very-secret-key-here-change-this-in-production
FLASK_ENV=development
FLASK_DEBUG=True
EOF
    print_status ".env file created. Please update SECRET_KEY before production!"
else
    print_warning ".env file already exists. Skipping creation."
fi

print_status "Creating .gitignore file..."
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Virtual Environment
flask_env/
venv/
ENV/
env/

# Flask
instance/
.webassets-cache

# Environment variables
.env
.env.local
.env.development
.env.production

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log
EOF
    print_status ".gitignore file created."
else
    print_warning ".gitignore file already exists. Skipping creation."
fi

print_status "Setup completed successfully! 🎉"
echo ""
echo "Next steps:"
echo "1. Activate the virtual environment: source flask_env/bin/activate"
echo "2. Follow the Phase 1.1 tutorial to create your Flask application"
echo "3. Run the application with: python run.py"
echo ""
echo "Useful Arch Linux commands:"
echo "- Check Python version: python --version"
echo "- List installed packages: pacman -Q | grep python"
echo "- Update system: sudo pacman -Syu"
echo ""
print_status "Happy coding! 🚀"
