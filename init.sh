# Deactivate and remove the existing virtual environment (if exists)
deactivate
rm -rf "venv"

## Create new virtual environment called 'venv'
python3 -m venv venv

## Activate the virtual environment based on OS
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    # For Linux and macOS
    source venv/bin/activate
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    # For Windows (Git Bash or Cygwin)
    source venv/Scripts/activate
else
    # For Windows (PowerShell and cmd)
    venv\Scripts\activate.bat
fi

## Install required libraries
python3 -m pip install -r requirements.txt

## Deploy and start the Docker container
docker-compose up -d

## Set dbt environment variables
export DB_USER="db_user"
export DB_PASSWORD="db_password"
export DBT_PROFILES_DIR="deploy"

## Initiate the database
export DATABASE_URL="postgres://${DB_USER}:${DB_PASSWORD}@localhost:5432/dev"
