# Purpose: Check for vulnerabilities, misconfigurations, and compliance issues
# Usage: sudo ./security_and_compliance_checker.sh
# Author: IT Support Team
# Version: 2.0
# Last Updated: 2025-03-15
# ========================================================================

# Color formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Log file
LOG_FILE="security_and_compliance_checker_$(date +%Y%m%d_%H%M%S).log"

# Function to print section headers
section() {
    echo -e "\n${BLUE}===== $1 =====${NC}\n"
    echo -e "===== $1 =====" >> "$LOG_FILE"
}

# Function to log command output
log_cmd() {
    echo -e "${CYAN}Running: $1${NC}"
    echo "Command: $1" >> "$LOG_FILE"
    eval "$1" | tee -a "$LOG_FILE"
    echo "" >> "$LOG_FILE"
}

# Function to check if script is running as root 
check_root() {
    if [ "$EUID" -ne 0]; then
        echo -e "${RED}This script needs to be run as root (sudo) for full functionality.${NC}"
        echo -e "${RED}Please restart with: sudo $0${NC}"
        exit 1
    fi
}

# Check for open ports using nmap
check_open_ports() {
    section "CHECKING OPEN PORTS"

    if command -v nmap &> /dev/null; then
        echo -e "${YELLOW}Lisitng open ports using nmap:${NC}"
        log_cmd "nmap -sT -O localhost"
    else
        echo -e "${YELLOW}nmap not found. Installing nmap package...${NC}"
        if command -v apt &> /dev/null; then
            apt intsall -y nmap
        elif command -v yum &> /dev/null; then
            yum install -y nmap
        else 
            echo -e "${RED}Cannot install nmap. Please install it manually.${NC}"
            echo "WARNING: nmap packages not installed." >> "$LOG_FILE"
        fi

}