#!/bin/bash

# Get battery percentage
BATTERY=$(cat /sys/class/power_supply/BAT1/capacity)
STATUS=$(cat /sys/class/power_supply/BAT1/status)

# Display with icon
if [ "$STATUS" = "Charging" ]; then
    echo "🔌 $BATTERY%"
elif [ "$BATTERY" -gt 50 ]; then
    echo "🔋 $BATTERY%"
elif [ "$BATTERY" -gt 20 ]; then
    echo "⚠️ $BATTERY%"
else
    echo "🪫 $BATTERY%"
fi
