# RuangUang

Web statis untuk membantu mahasiswa mencatat pemasukan dan pengeluaran, mengatur anggaran, melihat batas belanja harian, serta memantau target tabungan.

## Menjalankan di komputer sendiri

Perlu Python 3. Buka PowerShell di folder ini dan jalankan:

```powershell
.\start-lan.ps1
```

Jika Windows menolak menjalankan skrip, gunakan:

```powershell
powershell -ExecutionPolicy Bypass -File .\start-lan.ps1
```

Buka alamat `http://localhost:8000/` di komputer tersebut.

## Membuka dari perangkat lain di jaringan lokal

Jalankan skrip di komputer yang akan menjadi server. Gunakan alamat IP lokal yang dicetak skrip, misalnya `http://192.168.1.20:8000/`, pada perangkat yang tersambung ke Wi-Fi/LAN yang sama. Jika Windows Firewall meminta izin, izinkan Python hanya pada jaringan privat yang dipercaya. Jangan membuka akses jaringan publik untuk server pengembangan ini.

## Menerbitkan di PythonAnywhere

`flask_app.py` membungkus halaman statis dengan Flask agar bisa dijalankan melalui WSGI PythonAnywhere. Perlu akun PythonAnywhere; paket gratis dan pilihan Python yang tersedia mengikuti kebijakan akun saat deployment.

1. Buat akun/login ke [PythonAnywhere](https://www.pythonanywhere.com/).
2. Unduh `RuangUang-PythonAnywhere.zip`, lalu ekstrak di komputer. Arsip ini memuat halaman, aplikasi Flask, dan daftar dependensi.
3. Di dashboard PythonAnywhere, buka **Files**, buat folder `ruanguang` di home, lalu unggah `index.html`, `flask_app.py`, dan `requirements.txt` ke folder tersebut. Tidak perlu mengunggah `start-lan.ps1`.
4. Buka **Consoles → Bash** dan jalankan perintah berikut, ganti `USERNAME` dengan username PythonAnywhere kamu:

   ```bash
   cd /home/USERNAME/ruanguang
   python3 -m venv /home/USERNAME/.virtualenvs/ruanguang-venv
   /home/USERNAME/.virtualenvs/ruanguang-venv/bin/pip install -r requirements.txt
   ```

5. Dari tab **Web**, pilih **Add a new web app** → **Manual configuration**, lalu pilih versi Python yang tersedia dan sesuai dengan versi pada virtualenv.
6. Pada bagian **Virtualenv** di halaman Web, masukkan:

   ```text
   /home/USERNAME/.virtualenvs/ruanguang-venv
   ```

7. Klik tautan berkas WSGI di bagian **Code**, hapus konfigurasi aplikasi bawaan, lalu isi dengan kode berikut setelah mengganti `USERNAME`:

   ```python
   import sys

   project_path = "/home/USERNAME/ruanguang"
   if project_path not in sys.path:
       sys.path.insert(0, project_path)

   from flask_app import app as application
   ```

8. Simpan, kembali ke tab **Web**, tekan **Reload**, lalu buka domain yang diberikan PythonAnywhere.

PythonAnywhere dapat mengubah alur dashboard atau batas paketnya. Ikuti pilihan yang tampil di akunmu. Jangan mengekspos server pengembangan lokal langsung ke internet atau meneruskan port router.

## Privasi dan penyimpanan

Transaksi, anggaran, dan target disimpan di `localStorage` browser. Data tetap di browser/perangkat yang membuatnya dan tidak dikirim atau disinkronkan ke perangkat lain. Membuka situs melalui alamat lokal dan domain publik akan menghasilkan penyimpanan browser yang terpisah. Hindari mencatat informasi finansial sensitif pada perangkat bersama.
