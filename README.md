# Scan Multiple URL to see it's Subdomains and Check Live Host

Proyek ini merupakan assignment yang diberikan oleh salah satu mentor untuk mengetes kemampuan student dalam melakukan automation. Karena hal tersebut, saya membuat suatu program yang membantu untuk melihat subdomains yang terdapat di suatu domain dengan input domain yang lebih dari 1 (hingga 5) kemudian melihat host yang aktif dengan mengembalikan kode [200]. Kode program ini juga terdapat fitur untuk melihat list subdomain apabila terdapat penambahanan.

# Setup Environment

Agar dapat menggunakan bash ini, diperlukan beberapa hal yakni subfinder, httpx, anew, serta pdtm. Untuk melakukan setup tersebut, dapat dengan menggunakan github Mentor Yogi Kortisa yakni "https://gist.githubusercontent.com/yogikortisa/3101f7e80a31a63eff1536518423690
c/raw/e3f7f1549df8e22c9cbb029a59d24056152bb14d/setup-recon.sh", hak cipta dimiliki oleh mentor.
Setelah mengubah izin file setup-recon.sh menjadi _executable_, maka subfinder, httpx, anew, serta pdtm akan terinstall secara otomatis.

# How to run the scripts
Untuk menjalankan script, cukup dengan menggunakan file yang berada di direktori scripts kemudian akan diberikan suatu pilihan yakni 1 dan 2. Satu (1) untuk menggunakan domain yang telah diinput dan dua (2) untuk memasukkan domain yang baru.
Apabila memilih satu, user akan diminta untuk memasukkan 1 hingga 5 yang mewakili domain berdasarkan input sebelumnya yang akan dilakukan kemudian hasil keluaran adalah subdomain baru.
Apabila memilih dua, user akan diminta untuk memasukkan 5 domain yang akan dilakukan pencarian subdomain kemudian akan dilakukan otomatisasi untuk melakukan cek live host serta pemfilteran.
Seluruh hasil terdapat dalam direktori output, input akan terletak dalam direktori input, dan error beserta progress akan tersimpan di direktori logs.

# Input and Output Examples
Input
```
1. Input new data
2. Use data since last used
Enter (1/2)1
Enter first link : domain1
Enter second link   : domain2
Enter third link  : domain3
Enter fourth link : domain4
Enter fifth link  : domain5
```
Output
```
Showing data for domain1 :
https://x.domain1 [200] [contents]
https://y.domain1 [200] [contents]

...
Showing data for domain5 :
...
```
