export PackageID=0x0820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf 
export TreasuryCap=0x47e08d72079111f29294e13ec35763fe3a1c8a8981d89b6e9fc58d9b130e9bb2
sui client call --function mint --module lihuazhang_faucet_coin --package $PackageID --args $TreasuryCap 49999999999 0x2c3b24eee650f51ae02d36ffacbc16e4c4bde83dd11b747762239c4b7456178d  --gas-budget 300000000


0x9e4c8248d23a4ec339d61b9c277862197a44c0d730177f505ff34722bef44e96

sui client upgrade --gas-budget 300000000 --upgrade-capability 0x9e4c8248d23a4ec339d61b9c277862197a44c0d730177f505ff34722bef44e96