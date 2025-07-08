                                                                  EASY
       1. Atamalar ta'rifi
data- ya'ni ma'lumot bu faktlar,raqamlar, ko'rsatkichlar,statistika yoki kuzatuvlardan iborat bo'lib, ular tahlil qilish uchun, qaror qabul qilish yoki axborot olish uchun foydalaniladi.Masalan, '23', 'Asadbek', 'tarix'
database- ma'lumotlar bazasi bu ma'lumotlarni tartib bilan saqlash, boshqarish va uilardan samarali foydalanish uchun mo'ljallangan tizimdir
relational database- aloqaviy ma'lumotlar bazasi bu ustun(column) va qator(row) ko'rinishida jadval(table)larda saqlangan ma'lumotlar to'plami. Har bir jadvalda bir xil turdagi ma'lumotlar bo'ladi, va boshqa jadvallar bilan aloqa
(relatioship) orqali bog'lanishi mumkin. Masalan, Students table da ham va Books table da ham NameID bo'lsa bu jadvallar aynan NameID  orqali o'zaro bog'langan bo'ladi. 
table-jadval bu bir xil turdagi ma'lumotlar saqlanadigan katakli jadval bo'lib, u ustunlar(columns) va qatorlardan(rows) tashkil topgan.   
   2. List five key features of SQL Server
-1- SQL Server kuchli xavfsizlik tizimiga ega: Windows autentifikatsiyasi va SQL Server autentifikatsiyasi,Rol asosida kirish nazorati,Ma'lumotlarni shifrlash,kuzatish, qator darajasidagi xavfsizlik.
-2- T-SQL(Transact-SQL) yordamida ma'lumotlarni boshqarish - bu SQL ning kuchaytirilhan versiyasi u yordamida ma'lumotlarni qidirish, qo'shish, o'chirish mumkin.
-3- Biznes intellekt (BI) qo'llab-quvvatlaydi- SQL server Reporting Services (SSRS)-hisobotlar yaratish, SQL ServerIntegration Services(SSIS)-ma'lumotlarni birlashtirish, SQL Server analysis Sevices(SSAS)-tahliliy modellash
-4-Ma'lumotlar bazasini boshqarish qulayligi 
SQL Sever Management Studio  (SSMS) orqali vizual interfeysda bazani boshqarish, SQL so'rovlarini yozish va bajarish
zaxira, tiklash foydalanuvchi huquqlarini sozlash
-5- Sun'iy intellekt va Machine Learning integratsiyasi 
R va Python tillar yordamida model qurish va AI asosida real vaqtda bashorat qilish Machine Learning Services orqali bu imkoniyatlar qo'llab-quvvatlanadi
   3.Different authentication models when connecting to SQL Server
-1- SQL Server Authentication-Foydalanuvchi SQL Sever ning o'zida yaratilgan login va parol orqali tizimga ulanadi.
-2- Windows Autheentication- foydalanuvchi yoki tizimga kirishga foydalanayotgan Windows foydalanuchi hisobidan foydalanadi.
-3- Mixed mode authentication- ikkala usul Windows va SQL Sever authentication ni qo'llab-quvvatlaydi.

                                                                                 MEDIUM                                                     
Task 4- create database
Task 5- write and exec a query to create table
                  create database SchoolDB
                  go 
                  use SchoolDB
                  create table Students (StudentID int, PrimaryKey int, Name varchar(50), age int)

Task 6 - difference between SQL Server and SQl
-SQl Server-bu Microsoft tomonidan ishlab chiqilgan ma'lumotlar bazasini boshqarish tizimidir.U katta hajmdagi ma'lumotlarni saqlaydi, Ularni boshqaradi va tahlil qiladi
SQL yordamida so'rovlarni bajaradi.
-SQL - bu ma'lumotlar bazalari bilan ishlash uchun mo'ljallangan so'rovlar tili (query language). U ma'lumot qo'shish, o'chirish'yangilash, jadval va strukturalar yaratish yoki o'zgartirish kabi vazifalarni bajaradi.

                                                                             HARD
Task 7 research different SQL commands
-1-DQL-Data Query Language- ma'lumot tanlash ya'ni 'select'-ma'lumot tanlash uchun foydalanamiz
misol,Select 1 or Select * from Students
-2-DDL-Data Definition Language- jadval yoki strukturani o'zgartish uchun - 'create', 'alter', 'drop', 'truncate' buyruqlari orqali
 create- yaratish uchun  misol, create table or create database
 alter- orqali o'zgartirish kiritiladi ya'ni qo'shimcha qator qo'shish yoki o'chirish yoki datatype ni o'zgartirish uchun qo'llaniladi.
 drop- o'chirish uchun qo'llaniladi. Misol, drop table- table ni butunlay o'chirib tashlaydi
 truncate-qatorlarni datalardan tozalaydi faqat, table esa saqlanib qoladi
-3-DML-Data Manipulation Language- table ni ichiga ta'sir o'tkazadi- 'delete', 'update', 'insert'
 delete - o'chirish uchun, masalan, delete from students where id=2- tabledagi id=2 bo'lgan rowni o'chirib tashlaydi.
 update-o'zgartirish uchun, masalan, update  student set name = 'aziz' where id=2 - tabledagi id=2 bo'lgan name columni azizga o'zgartiradi.
 insert- data(ma'lumot) kiritish uchun foydalaniladi.
-4-TCL-Transaction Control Language- tranzaksiyalarni boshqarish uchun ishlatiladi.Misol,
begin tran 
delete from students
where id=2
rollback
 yuqoridagi buyruqlar table dastlabli holatiga qaytarish uchun ishlatilinadi.
commit- esa o'zgartirish kiritmaslik uchun.
-5-DCL-Data Control Language- foydalanuvchi huqularini boshqarish uchun foydalaniladi.
revoke-ruxsatni bekor qilish uchun
grant-ruxsat berish uchun

Task 8 write a query to inrest  three records into Students table;
        insert into Students values (1, 01, 'Edward', 12), (2, 02, 'Tom', 15), (3, 03, 'Johnny', 14)

Task 9 restore
dastlab faylni yuklab oldim, so'ng faylni SQL Server ning default backup papkasiga o'tkazdim, keyin Serverga kirdm restore database qildm va this device qildim ,three dot ni tanlab add qilib faylni tanladim so'ng 
ketma ketlikda ok ni bosib faylni restore qildim.
