#!/bin/bash
ip -4 addr show scope global | grep inet | awk '{print }' | cut -d/ -f1 | head -n 1
