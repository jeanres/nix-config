#!/usr/bin/env bash

# Check if psql is installed
if ! command -v psql &> /dev/null; then
    echo "Error: psql is not installed or not in PATH"
    echo "Please install PostgreSQL client tools"
    read -p "Press any key to continue..."
    exit 1
fi

# Function to search for connection strings in project files
find_connection_strings() {
    local project_root="${1:-$(pwd)}"
    local connections=()
    
    # Search for actual PostgreSQL connection strings
    while IFS= read -r -d '' file; do
        # Look for full connection strings
        local conn_strings=$(grep -ho "postgresql://[^\"'[:space:];]*" "$file" 2>/dev/null)
        local postgres_strings=$(grep -ho "postgres://[^\"'[:space:];]*" "$file" 2>/dev/null)
        
        if [[ -n "$conn_strings" ]]; then
            while IFS= read -r conn; do
                [[ -n "$conn" ]] && connections+=("$(basename "$file"): $conn")
            done <<< "$conn_strings"
        fi
        
        if [[ -n "$postgres_strings" ]]; then
            while IFS= read -r conn; do
                [[ -n "$conn" ]] && connections+=("$(basename "$file"): $conn")
            done <<< "$postgres_strings"
        fi
        
        # Look for DATABASE_URL env var
        local db_url=$(grep -o "DATABASE_URL[[:space:]]*=[[:space:]]*[\"']*postgresql://[^\"'[:space:]]*" "$file" 2>/dev/null | sed "s/.*postgresql:/postgresql:/")
        if [[ -n "$db_url" ]]; then
            connections+=("$(basename "$file") (DATABASE_URL): $db_url")
        fi
        
        local db_url_postgres=$(grep -o "DATABASE_URL[[:space:]]*=[[:space:]]*[\"']*postgres://[^\"'[:space:]]*" "$file" 2>/dev/null | sed "s/.*postgres:/postgres:/")
        if [[ -n "$db_url_postgres" ]]; then
            connections+=("$(basename "$file") (DATABASE_URL): $db_url_postgres")
        fi
        
    done < <(find "$project_root" \( -name "*.env*" -o -name "*.yaml" -o -name "*.yml" -o -name "*.json" -o -name "*.toml" -o -name "docker-compose*" -o -name "*.js" -o -name "*.ts" -o -name "*.py" \) -type f -print0 2>/dev/null)
    
    # Remove duplicates and return
    printf '%s\n' "${connections[@]}" | sort -u
}

# Function to extract connection string from selection
parse_connection() {
    local selection="$1"
    
    if [[ "$selection" == *": postgresql://"* ]]; then
        echo "${selection#*: }"
    elif [[ "$selection" == *": postgres://"* ]]; then
        echo "${selection#*: }"
    elif [[ "$selection" == "Local: postgresql://localhost:5432/postgres" ]]; then
        echo "postgresql://localhost:5432/postgres"
    elif [[ "$selection" == "Manual entry" ]]; then
        echo "MANUAL"
    elif [[ "$selection" == "Local custom database" ]]; then
        echo "CUSTOM"
    else
        echo "postgresql://localhost:5432/postgres"
    fi
}

# Main execution
main() {
    local project_root="${1:-$(pwd)}"
    
    # Find connection strings
    local connections
    connections=$(find_connection_strings "$project_root")
    
    # Add default options
    local default_connections=(
        "Local: postgresql://localhost:5432/postgres"
        "Local custom database"
        "Manual entry"
    )
    
    # Combine found connections with defaults
    local all_connections
    if [[ -n "$connections" ]]; then
        all_connections=$(printf '%s\n' "$connections" "${default_connections[@]}")
    else
        all_connections=$(printf '%s\n' "${default_connections[@]}")
    fi
    
    # Show selection menu
    local selected_connection
    selected_connection=$(echo "$all_connections" | fzf --prompt="Select database: " --height=40% --reverse)
    
    if [[ -z "$selected_connection" ]]; then
        echo "No database selected. Press any key to exit..."
        read -n 1
        exit 0
    fi
    
    # Parse the connection
    local connection_string
    connection_string=$(parse_connection "$selected_connection")
    
    # Handle special cases
    if [[ "$connection_string" == "MANUAL" ]]; then
        echo -n "Enter connection string: "
        read -r connection_string
        if [[ -z "$connection_string" ]]; then
            echo "No connection string provided. Press any key to exit..."
            read -n 1
            exit 1
        fi
    elif [[ "$connection_string" == "CUSTOM" ]]; then
        echo -n "Enter database name: "
        read -r db_name
        if [[ -z "$db_name" ]]; then
            echo "No database name provided. Press any key to exit..."
            read -n 1
            exit 1
        fi
        connection_string="postgresql://localhost:5432/$db_name"
    fi
    
    clear
    echo "Connecting to: $connection_string"
    echo "Type \\q to quit, \\? for help"
    echo "========================================="
    echo
    
    # Start psql session - use exec to replace current process
    exec psql "$connection_string"
}

# Run main function with arguments
main "$@"