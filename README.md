# Phoenix XP (XP)

Token ERC-20 yang ditulis dari nol dalam Solidity, di-deploy dan diverifikasi di jaringan publik Ethereum (Sepolia Testnet), sebagai proyek pembelajaran pengembangan smart contract.

## 🔗 Live Links

- **Portfolio Page:** https://bjsatria7.github.io/phoenix-xp-token/
- **Source Code:** https://github.com/BJSatria7/phoenix-xp-token
- **Bukti deployment on-chain (Etherscan):** https://sepolia.etherscan.io/token/0x88C2e42B4f752782BC81516d4b2C350c56c3777f

## 📋 Detail Token

| Properti | Nilai |
|---|---|
| Nama | Phoenix XP |
| Simbol | XP |
| Standar | ERC-20 (EIP-20) |
| Total Supply | 1.000.000.000 XP |
| Decimals | 18 |
| Jaringan | Ethereum Sepolia Testnet |
| Contract Address | `0x88C2e42B4f752782BC81516d4b2C350c56c3777f` |
| Holders | 1 |
| Total Transfers | 1 (mint awal) |

## 🛠️ Tech Stack

- **Bahasa:** Solidity ^0.8.20
- **IDE:** Remix
- **Jaringan:** Ethereum Sepolia Testnet
- **Wallet:** MetaMask / Brave Wallet (via WalletConnect)
- **Verifikasi:** Blockscout, Sourcify

## ✨ Fitur Kontrak

- Fungsi standar ERC-20 penuh: `transfer`, `approve`, `transferFrom`, `balanceOf`, `allowance`
- `mint()` — owner dapat mencetak token baru (khusus mode edukasi/testnet)
- `burn()` — siapa pun dapat membakar token miliknya sendiri
- Event logging lengkap (`Transfer`, `Approval`, `Mint`, `Burn`) sesuai konvensi EIP-20

## 📚 Proses Pengembangan

1. Menulis smart contract ERC-20 dari nol (tanpa library eksternal) untuk memahami setiap baris logikanya
2. Compile & deploy ke Sepolia Testnet menggunakan Remix IDE
3. Meminta audit keamanan independen atas kode — hasil: bebas reentrancy & bug aritmetika, namun perlu penyesuaian tata kelola kepemilikan (ownership) sebelum layak ke mainnet
4. Verifikasi source code secara publik di Blockscout & Sourcify

## ⚠️ Catatan

Kontrak ini berjalan di **testnet** (tanpa nilai finansial riil) dan dibuat untuk **tujuan pembelajaran**. Sebelum dipertimbangkan untuk mainnet, kontrak ini memerlukan migrasi ke standar OpenZeppelin v5 (`Ownable2Step`, `ERC20Permit`, kebijakan supply tetap/capped) sesuai rekomendasi audit.

## 👤 Author

**Jafar Satria** — Jakarta, Indonesia
