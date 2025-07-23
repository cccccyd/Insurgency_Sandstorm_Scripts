# This Script for Start Server with Random Scenario in Insurgency/Insurgency/Config/Server/MapCycle.txt
while [ 1 == 1 ]
do
MAP_CYCLE_FILE="Insurgency/Insurgency/Config/Server/MapCycle.txt"
RANDOM_SCENARIO=$(shuf -n 1 "$MAP_CYCLE_FILE" | sed -n 's/.*Scenario="\([^"]*\)".*/\1/p')
MAP_NAME=$(echo "$RANDOM_SCENARIO" | sed 's/Scenario_\([^_]*\).*/\1/')
case $MAP_NAME in
        Crossing)
                MAP_NAME=Canyon
                ;;
        Hideout)
                MAP_NAME=Town
                ;;
        Hillside)
                MAP_NAME=Sinjar
                ;;
        Outskirts)
                MAP_NAME=Compound
                ;;
        Refinery)
                MAP_NAME=Oilfield
                ;;
        Summit)
                MAP_NAME=Mountain
                ;;
        Tideway)
                MAP_NAME=Buhriz
                ;;
esac

./Insurgency/Insurgency/Binaries/Linux/InsurgencyServer-Linux-Shipping \
$MAP_NAME?Scenario=$RANDOM_SCENARIO?MaxPlayers=8 \
-Port=30000 \
-QueryPort=30001 \
-Rcon -RconPassword=XXXXXXXXXXXXXX -RconListenPort=20001 \
-NoEAC \
-log \
-hostname="HOSTNAME" \
-GameStatsToken=XXXXXXXXXXXXXXXXXXXXXXXXX \
-GSLTToken=XXXXXXXXXXXXXXXXXXXXXXXXX
done
