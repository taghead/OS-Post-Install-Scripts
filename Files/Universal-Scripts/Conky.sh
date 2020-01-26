#Download Conky Configuration
wget https://gitlab.com/Taghead/linux-install-scripts/raw/master/Files/Configs/conky.config -O ~/.conkyrc

#Get network adapters       |       Assumes first interfaces listed are the primary network adapters. 
ethernet=`ip -o link show | awk -F': ' '{print $2}' | grep enp*`
wireless=`ip -o link show | awk -F': ' '{print $2}' | grep wlp*`
tunnel=`ip -o link show | awk -F': ' '{print $2}' | grep tun*`

if [ $ethernet ] 
then 
    echo "Conky assuming $ethernet as ethernet."
    sed -i "s/enp2s0/$ethernet/g" ~/.conkyrc
else 
    echo ":'( Conky cannot assume a ethernet interface."  
fi 
if [ $wireless ] 
then 
    echo "Conky assuming $wireless as wireless."
    sed -i "s/wlp4s0/$wireless/g" ~/.conkyrc
else
    echo ":'( Conky cannot assume a tunnel interface."
fi  
if [ $tunnel ]
then 
    echo "Conky assuming $tunnel as tunnel."
    sed -i "s/tun0/$tunnel/g" ~/.conkyrc
else 
    echo ":'( Conky cannot assume a tunnel interface."
fi 
