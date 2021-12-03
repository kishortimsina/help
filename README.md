
You can clone this repo and run periodically so you have automated job to pull and analyze stock status.

# Project Configuration

Please run below commands to configure project locally

```sh
yum/brew/apt install git jq -y
mkdir -p /app/stock/lazy-noob
cd /app/stock && git clone git@github.com:poudelpra/lazy-noob.git
```

Follow below scripts to Download data in your local for stock and crypto respectively; for initial test would recommend few run

```sh
/app/stock/lazy-noob/script/SplitStocks.sh && for i in {1..7};do /app/stock//script/lazy-noob/DownloadData${i}.sh & done
/app/stock/lazy-noob/script/CryptoDownload.sh
```

Additionally, run below to compare Stocks and Cryptos respectively

```sh
/app/stock/lazy-noob/script/HistoricPriceComparisn.sh
/app/stock/lazy-noob/script/CryptoComparisn.sh
```


## Release History

* 0.0.1
    * Initial Project Push
* 0.0.1
    * CHANGE: Progress

## Meta
Prakash Poudel – [@Linkedin](https://www.linkedin.com/in/prakash-poudel-1b6387102/) – poudelpra@gmail.com
[https://github.com/poudelpra](https://github.com/poudelpra)

## Contributing
1. Fork it (<https://github.com/poudelpra/lazy-noob>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
