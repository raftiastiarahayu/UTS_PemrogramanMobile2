# 📚 UTS Pemrograman Mobile – Aplikasi Kasir Warung  
**Nama:** Rafti Astia Rahayu  
**NIM:** 23552011392  

Aplikasi ini dibangun menggunakan **Flutter** dan **Cubit** sebagai state management.  
Fitur utama meliputi: pemilihan kategori menggunakan Stack, perhitungan diskon per item, serta diskon total transaksi otomatis.

**Bagian A - Teori**
### **1. Manfaat Cubit untuk transaksi dengan diskon dinamis**
Cubit membantu mengelola transaksi karena:
- Menyimpan daftar pesanan dan kuantitasnya.
- Memproses logika diskon di satu tempat (tidak tercampur dengan UI).
- UI otomatis berubah saat state berubah (BlocBuilder).
- Memudahkan pemeliharaan dan testing.

Cubit membuat alur transaksi lebih rapi dan konsisten karena seluruh perhitungan diskon dikelola oleh Cubit, bukan UI.


**perbedaan diskon per item dan diskon total transaksi:**
•	Diskon per item: tiap menu punya properti discount → dihitung pada masing-masing item. 
Contoh: Nasi Goreng (Rp30.000, diskon 0.1) → harga setelah diskon = Rp27.000. Jika pesan 2 → subtotal = 2 * 27.000.
•	Diskon total transaksi: diskon diterapkan pada total akhir (setelah menjumlah semua item). 
Contoh: Total sebelum diskon Rp200.000, diskon total 0.1 → bayar Rp180.000.
Perbedaan: diskon per item lebih granular (promo per menu), diskon total cocok untuk promo seperti “diskon 10% jika belanja di atas Rp100.000”.

**Manfaat penggunaan widget Stack untuk tampilan kategori:**
•	Stack memungkinkan menumpuk widget secara z-axis sehingga menghasilkan UI menarik (kartu kategori tumpuk, overlapping).
•	Berguna untuk membuat efek visual seperti kartu kategori yang saling menonjol ketika dipilih.
•	Digabungkan dengan GestureDetector bisa membuat kategori interaktif, serta mudah memberi efek transisi/animasi saat seleksi.

**Note:**
category_cubit.dart ditambahkan karena pada soal bagian B “Gunakan Cubit untuk memastikan hanya kategori yang dipilih yang aktif.”
kategori menu perlu disimpan sebagai state. Dengan Cubit, aplikasi bisa mengetahui kategori mana yang sedang dipilih dan otomatis mengubah tampilan pada halaman Stack. Cubit memastikan hanya satu kategori aktif, tampilan mudah diperbarui, dan struktur proyek tetap rapi serta modular sesuai prinsip pemisahan logika bisnis.

<img width="960" height="540" alt="image" src="https://github.com/user-attachments/assets/f50dc374-2023-49e3-a000-cdefbac31485" />
<img width="960" height="400" alt="image" src="https://github.com/user-attachments/assets/688c3a33-c04c-4b62-b8ae-76899c5fea43" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/034ddb8a-77b7-4a23-98d4-6d4163bd0daf" />

