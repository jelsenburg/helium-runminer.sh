echo “Auto clearing and updating Helium Miner” \ 
docker stop miner
docker rm miner
rm -r ~/miner_data/blockchain.db
rm -r ~/miner_data/blockchain_swarm
rm -r ~/miner_data/ledger.db
rm -r ~/miner_data/log
rm -r ~/miner_data/saved-snaps
rm -r ~/miner_data/snaps
apt update &&  apt dist-upgrade -y &&  apt autoremove
docker run -d \
--env REGION_OVERRIDE=US915 \
--restart always \
--publish 1680:1680/udp \
--publish 44158:44158/tcp \
--name miner \
--mount type=bind,source=/root/miner_data,target=/var/data \
quay.io/team-helium/miner:latest-amd64
docker system prune -f 
docker ps
docker images
