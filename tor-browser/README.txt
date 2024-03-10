volumes:
  ./tor-browser -> ~/volumes/tor-browser:/home/tor-browser

git clone https://github.com/pufferffish/wireproxy -> ./wireguard/wireguard
 
ln tor-browser-linux-x86_64-13.0.11.tar.xz  tor-browser.tar.xz

docker-compose up -d
docker-compose exec tor-browser bash --login

tor-browser proxy: socks5://wireproxy:9050

docker-compose exec curl sh
curl -v -x socks5://wireproxy:9050 https://ipinfo.io

docker-compose logs wireproxy

https://support.torproject.org/ru/apt/

apt install apt-transport-tor --no-install-recommends

apt-get install xz-utils


make git
git clone https://github.com/pufferffish/wireproxy
cd wireproxy
make
