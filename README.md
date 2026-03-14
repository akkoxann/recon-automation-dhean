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
Input 1
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
Output 1
```
Showing data for domain1 :
https://x.domain1 [200] [contents]
https://y.domain1 [200] [contents]

...
Showing data for domain5 :
...
```
Input 2
```
1. Input new data
2. Use data since last used
Enter (1/2)2
Which link you want to check again?
1 domain1
2 domain2
3 domain3
4 domain4
5 domain5
1 to 5?1
domain1 was checked and we found this :
...
```

# Penjelasan Singkat Kode
Digunakan untuk redirect error
```
: > ../logs/errors.log

read -p "1. Input new data
2. Use data since last used
Enter (1/2)" CEK
```
Kasus apabila menggunakan data lama sekaligus melihat domain keberapa yang ingin di cek ulang kemudian menambahkan ke file output sekaligus cek eror apabila masukan bukan diantara 1 dan 5.
```
if [[ $CEK == 2 ]]; then
	echo "[SEPERATOR] ========== SEPERATING LOGS ==========" >> ../logs/progress.log
	
	echo "[Starting] Check using old data" >> ../logs/progress.log
	echo "[DATA] Using old data to check" >> ../logs/progress.log
	
	domain=($(cut ../input/domains.txt -d' ' -f1-5))
	
	echo "Which link you want to check again?"
	
	i=1
	for item in "${domain[@]}"; do
		echo "[INFO] Printing old data number $i" >> ../logs/progress.log
		echo "$i $item"
		((i++))
	done
	
	read -p "1 to 5?" FILE
	
	if (( $FILE <= 5 && $FILE >=1 )) ; then
		targetold=${domain[$((FILE-1))]}

	
		echo "[INFO] Adding new information from $targetold" >> ../logs/progress.log
	
		echo "$targetold was checked and we found this :" 
		subfinder -d $targetold -silent | httpx -status-code -mc 200 -silent -title | anew ../output/output.txt 2>> ../logs/error.log
	else
		echo "[ERROR] Input is either more than 5 or less than 1"
		echo "[ERROR] Input is either more than 5 or less than 1" >> ../logs/errors.log
	fi	
```

Memasukkan semua domain yang ingin di cek kemudian mencari subdomain masing masin kemudian memfilter berdasarkan kode yakni [200] kemudian dimasukkan ke file output.txt.
```
elif [[ $CEK == 1 ]] ; then
	echo "[Removing] Old data is being removed . . ." >> ../logs/progress.log
	
	: > ../output/output.txt
	: > ../logs/progress.log
	
	echo "[Starting] Adding new data" >> ../logs/progress.log
	
	read -p "Enter first link : " TARGET1
	read -p "Enter second link   : " TARGET2
	read -p "Enter third link  : " TARGET3
	read -p "Enter fourth link : " TARGET4
	read -p "Enter fifth link  : " TARGET5

	echo "$TARGET1 $TARGET2 $TARGET3 $TARGET4 $TARGET5" > ../input/domains.txt 2>> ../logs/error.log

	domain=($(cut ../input/domains.txt -d' ' -f1-5))

	for item in "${domain[@]}"; do
		echo "[INFO] Starting subfinder for $item" >> ../logs/progress.log
		echo "Showing data for $item" >> ../output/output.txt
		echo "Showing data for $item :"
		echo ""
		subfinder -d $item -silent | httpx -status-code -mc 200 -silent -title | sort -u |  tee -a ../output/output.txt 2>> ../logs/error.log
		echo " " >> ../output/output.txt
		echo ""
		echo "[INFO] Done for $item !" >> ../logs/progress.log
		echo "[INFO] Continuing . . ." >> ../logs/progress.log
	done
```

Output apabila input bukan 1 atau 2 pada bagian menggunakan data lama atau memasukkan data baru kemudian memasukkan tanda error ke errors.log
```
else
	echo "[ERROR] Input not valid"
	echo "[ERROR] Input not valid" >> ../logs/errors.log
fi
```
# Screenshot Terminal
Gambar apabila input adalah 1 yakni memasukkan input baru
![Gambar 1](foto%20terminal%20input%201.png)

Gambar apabila input adalah 2 yakni menggunakan input lama untuk mengecek subdomain baru



![Gambar 2](foto%20terminal%20input%202.png)
