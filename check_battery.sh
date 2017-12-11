BATT_PERCENT=$(termux-battery-status | grep percentage | cut -d: -f2 | tr -d ' ', )
CHARGING=$(termux-battery-status | grep status | cut -d: -f2 | tr -d '"'' ',)


if (( $BATT_PERCENT < 25 )) && [ $CHARGING == "CHARGING" ]
then
echo "ok"
else
echo "low"
fi
