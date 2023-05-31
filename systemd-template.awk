#!/usr/bin/awk -f

# Configuration variables
BEGIN {
 #   username = "your_username"
 #   daemon_executable = "your_daemon_executable"
 #   service_name = "your_service_name"
 #   filesystem_root = "your_filesystem_root"
}

# Service file template
END {
    printf("[Unit]\n")
    printf("Description=%s\n", service_name)
    printf("After=network.target\n")
    printf("StartLimitIntervalSec=0\n\n")
    printf("[Service]\n")
    printf("Type=simple\n")
    printf("Restart=always\n")
    printf("RestartSec=1\n")
    printf("User=%s\n", username)
    printf("ExecStart=%s/%s\n", filesystem_root, daemon_executable)
    printf("\n[Install]\n")
    printf("WantedBy=multi-user.target\n")
}

