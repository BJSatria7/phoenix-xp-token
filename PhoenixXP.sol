// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * Phoenix XP (XP) — Token ERC-20 sederhana untuk pemula
 * -------------------------------------------------
 * Contract ini SENGAJA ditulis "dari nol" (tanpa import dari OpenZeppelin)
 * supaya gampang dibaca baris per baris dan gampang dipahami dari nol.
 * Fungsinya sudah comply dengan standar ERC-20, jadi bisa langsung
 * dikenali MetaMask, Etherscan, dan exchange manapun.
 *
 * CATATAN PENTING:
 * - Contract ini cocok untuk BELAJAR dan TESTNET.
 * - Kalau nanti mau dipakai untuk token "real" dengan nilai riil (mainnet),
 *   sebaiknya diaudit dulu oleh pihak ketiga, atau pakai library yang
 *   sudah teraudit seperti OpenZeppelin, karena contract ini belum
 *   pernah diaudit secara profesional.
 */
contract PhoenixXP {

    // ------------------------------------------------------------
    // 1. METADATA TOKEN — SUDAH DI-HARDCODE, gak perlu isi apa-apa
    //    lagi pas deploy. Kalau suatu saat mau ganti nama/simbol/
    //    supply, tinggal edit angka & teks di 3 baris bawah ini.
    // ------------------------------------------------------------
    string public name = "Phoenix XP";
    string public symbol = "XP";
    uint8 public decimals = 18; // Jumlah angka desimal (standar = 18, sama seperti ETH)
    uint256 public totalSupply; // Total token yang beredar (dihitung otomatis di constructor)

    // Jumlah token awal dalam angka "manusia" (BUKAN dikali 10^18 di sini,
    // itu bakal dihitung otomatis di constructor supaya gak salah input)
    uint256 public constant INITIAL_SUPPLY = 1_000_000_000; // 1 miliar XP

    // Alamat wallet yang membuat & mengontrol contract ini
    address public owner;

    // ------------------------------------------------------------
    // 2. BUKU BESAR (LEDGER) — mencatat siapa punya berapa token
    // ------------------------------------------------------------
    mapping(address => uint256) public balanceOf;
    // allowance[pemilik][pihakLain] = berapa token yang diizinkan
    // dipakai oleh pihak lain atas nama si pemilik (dipakai exchange/dApp)
    mapping(address => mapping(address => uint256)) public allowance;

    // ------------------------------------------------------------
    // 3. EVENT — "log" yang dicatat permanen di blockchain,
    //    dipakai wallet/explorer untuk melacak histori transaksi
    // ------------------------------------------------------------
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    // Modifier = "penjaga pintu" yang mengecek syarat sebelum fungsi jalan
    modifier onlyOwner() {
        require(msg.sender == owner, "Hanya owner yang boleh panggil fungsi ini");
        _;
    }

    // ------------------------------------------------------------
    // 4. CONSTRUCTOR — kode yang jalan SEKALI SAJA saat contract
    //    pertama kali di-deploy ke blockchain.
    //    TIDAK ADA PARAMETER LAGI — jadi di Remix nanti kotak
    //    input constructor bakal KOSONG, tinggal klik Deploy langsung.
    // ------------------------------------------------------------
    constructor() {
        owner = msg.sender; // yang deploy contract otomatis jadi owner

        // INITIAL_SUPPLY dikali 10^18 karena token pakai 18 angka desimal
        totalSupply = INITIAL_SUPPLY * (10 ** uint256(decimals));

        // Seluruh supply awal (1 miliar XP) masuk ke wallet yang deploy contract
        balanceOf[msg.sender] = totalSupply;

        // Event Transfer dari alamat "0x0" menandakan token baru dicetak
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // ------------------------------------------------------------
    // 5. TRANSFER — fungsi paling inti: kirim token ke orang lain
    // ------------------------------------------------------------
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Tidak bisa transfer ke alamat kosong");
        require(balanceOf[msg.sender] >= _value, "Saldo tidak cukup");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // ------------------------------------------------------------
    // 6. APPROVE & TRANSFERFROM — dipakai exchange/dApp untuk
    //    memindahkan token ATAS NAMA pengguna (dengan izin pengguna)
    // ------------------------------------------------------------
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Tidak bisa transfer ke alamat kosong");
        require(balanceOf[_from] >= _value, "Saldo pengirim tidak cukup");
        require(allowance[_from][msg.sender] >= _value, "Allowance tidak cukup");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    // ------------------------------------------------------------
    // 7. MINT — owner bisa cetak token baru (opsional, bisa dihapus
    //    kalau mau supply tetap/fixed selamanya)
    // ------------------------------------------------------------
    function mint(address _to, uint256 _amount) public onlyOwner {
        totalSupply += _amount;
        balanceOf[_to] += _amount;
        emit Mint(_to, _amount);
        emit Transfer(address(0), _to, _amount);
    }

    // ------------------------------------------------------------
    // 8. BURN — siapa saja bisa "membakar" (menghanguskan) token
    //    miliknya sendiri, mengurangi total supply
    // ------------------------------------------------------------
    function burn(uint256 _amount) public {
        require(balanceOf[msg.sender] >= _amount, "Saldo tidak cukup untuk burn");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Burn(msg.sender, _amount);
        emit Transfer(msg.sender, address(0), _amount);
    }
}
