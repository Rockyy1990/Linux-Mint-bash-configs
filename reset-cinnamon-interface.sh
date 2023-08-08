#!/usr/bin/env bash

echo ""
echo "Reset Cinnamon interface"
sleep 3

gsettings reset-recursively org.cinnamon

echo "Reset complete."
exit