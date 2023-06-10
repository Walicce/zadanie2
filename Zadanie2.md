<b>Zadanie 2 - Github Actions i Docker</b>

W ramach tego zadania będziemy modyfikować aplikację React z laboratorium 12 oraz opracujemy łańcuch działań w ramach Github Actions, który pozwoli na zbudowanie obrazów Docker zgodnych z OCI dla dwóch architektur sprzętowych: x86_64 oraz arm64.

Zadania do wykonania

<b>a. Modyfikacja kodu źródłowego aplikacji React </b>
Należy zmodyfikować kod źródłowy aplikacji React tak, aby wyświetlał imię oraz nazwisko studenta. Tekst pod symbolem „atomu” powinien być odpowiednio zmieniony.

<img width="898" alt="Zrzut ekranu 2023-06-9 o 11 57 54" src="https://github.com/Walicce/zadanie2/assets/60614660/658ecd0c-a829-420a-9b76-f55092be5429">

<b>b. Opracowanie łańcucha działań w ramach Github Actions </b>
Należy opracować łańcuch działań w ramach Github Actions, który pozwoli na zbudowanie obrazów Docker zgodnych z OCI dla dwóch architektur sprzętowych: x86_64 oraz arm64. Procesor M1/M2.
<img width="1440" alt="Zrzut ekranu 2023-06-10 o 21 00 37" src="https://github.com/Walicce/zadanie2/assets/60614660/f33a982a-2fdf-488f-9af5-d2e7b18464cb">
<br>
Docker.yml definiuje łańcuch działań w ramach Github Actions, który ma na celu zbudowanie i przesłanie obrazów Docker o dwóch różnych architekturach (x86_64 i arm64). Poniżej znajduje się krótkie omówienie poszczególnych kroków w tym łańcuchu działań:
<br>
Checkout repository:
<br>
Ten krok korzysta z akcji actions/checkout@v3 i służy do sklonowania repozytorium, aby uzyskać dostęp do kodu źródłowego.
<br>
Set up QEMU:
<br>
Ten krok korzysta z akcji docker/setup-qemu-action@v2 i służy do konfiguracji QEMU w środowisku, aby umożliwić budowanie obrazów dla architektury arm64 na maszynie x86_64.
<br>
Set up Docker Buildx:
<br>
Ten krok korzysta z akcji docker/setup-buildx-action@v2 i służy do konfiguracji narzędzia Docker Buildx, które umożliwia wieloplatformowe budowanie obrazów Docker.
<br>
Login to Docker Hub:
<br>
Ten krok korzysta z akcji docker/login-action@v2 i służy do zalogowania się do Docker Hub, aby umożliwić przesłanie zbudowanych obrazów.
<br>
Build and push Docker image (x86_64):
<br>
Ten krok buduje obraz Docker dla architektury x86_64 i przesyła go do Docker Hub. Parametr --platform linux/amd64 określa, że obraz jest budowany dla tej architektury.
<br>
Build and push Docker image (arm64):
<br>
Ten krok buduje obraz Docker dla architektury arm64 i przesyła go do Docker Hub. Parametr --platform linux/arm64 określa, że obraz jest budowany dla tej architektury. Dodatkowo, w sekcji env są ustawione zmienne środowiskowe DOCKER_BUILDKIT, DOCKER_CLI_EXPERIMENTAL oraz DOCKER_BUILDKIT_INLINE_CACHE, które mają wpływ na sposób budowania obrazu.
<br>
Ten łańcuch działań umożliwia automatyczne budowanie i przesyłanie obrazów Docker do Docker Hub dla dwóch różnych architektur.
<img width="915" alt="Zrzut ekranu 2023-06-9 o 14 28 27" src="https://github.com/Walicce/zadanie2/assets/60614660/a7ba5dd6-8255-4394-a049-874b9ae0f719">

<b>c. Testowanie obrazu pod kątem CVE</b>
Obraz Docker, który został zbudowany, powinien zostać poddany testowi pod kątem CVE z wykorzystaniem dowolnego z trzech narzędzi przedstawionych w instrukcji do laboratorium nr 12. Obraz nie może mieć żadnych zagrożeń krytycznych.
Do testów pod kątem CVE zostało użyte narzędzie Snyk https://app.snyk.io
<br>
<img width="867" alt="Zrzut ekranu 2023-06-9 o 14 20 45" src="https://github.com/Walicce/zadanie2/assets/60614660/632a632e-e85b-44b3-a88a-b9554ecb5cac">
<br>
<img width="564" alt="Zrzut ekranu 2023-06-9 o 14 21 13" src="https://github.com/Walicce/zadanie2/assets/60614660/e7c034f1-dd68-4bc5-8338-d8361d8cfde3">

<b>d. Używanie cache w trybie inline</b>
W trakcie budowania obrazów Docker należy korzystać z cache w trybie inline, aby przyspieszyć proces budowania.

<img width="596" alt="Zrzut ekranu 2023-06-9 o 14 31 01" src="https://github.com/Walicce/zadanie2/assets/60614660/a10d4073-71bb-431d-a2fc-38b6ca6aec6c">

<b>e. Przesłanie obrazu do repozytorium Github Packages</b>
Po zbudowaniu obrazu, w ramach działań w Github Actions, obraz powinien zostać przesłany do repozytorium na Github Packages (repo: ghcr.io).

<img width="1415" alt="Zrzut ekranu 2023-06-10 o 21 07 06" src="https://github.com/Walicce/zadanie2/assets/60614660/d20970f6-4a5f-45e5-b3f7-bc6ec7b3262f">
<img width="1440" alt="Zrzut ekranu 2023-06-10 o 21 01 05" src="https://github.com/Walicce/zadanie2/assets/60614660/c7deda67-0335-42ed-bd65-bb66cfb90e47">
<br>
Checkout repository:
<br>
Ten krok korzysta z akcji actions/checkout@v3 i służy do sklonowania repozytorium, aby uzyskać dostęp do kodu źródłowego.
<br>
Set up QEMU:
<br>
Ten krok korzysta z akcji docker/setup-qemu-action@v2 i służy do konfiguracji QEMU w środowisku, aby umożliwić budowanie obrazów dla architektury arm64 na maszynie x86_64.
<br>
Set up Docker Buildx:
<br>
Ten krok korzysta z akcji docker/setup-buildx-action@v2 i służy do konfiguracji narzędzia Docker Buildx, które umożliwia wieloplatformowe budowanie obrazów Docker.
<br>
Log in to GitHub Packages:
<br>
Ten krok loguje się do GitHub Packages za pomocą tokena przechowywanego jako tajna wartość (secrets.GHUB_TOKEN). Używamy tego logowania, aby móc przesłać obraz Docker do repozytorium GitHub Packages.
<br>
Build and push Docker image:
<br>
Ten krok buduje obraz Docker dla architektur linux/amd64 i linux/arm64, a następnie przesyła go do repozytorium GitHub Packages (ghcr.io/walicce/walicce/zadanie2). Wykorzystywany jest identyfikator wersji (github.sha), aby utworzyć unikalne oznaczenie obrazu.
<br>
Create package:
<br>
Ten krok tworzy pakiet w GitHub Packages, wykorzystując API GitHub. Uzyskany identyfikator pakietu jest przekazywany jako wynik (package_id) do kolejnego kroku.
<br>
Add package to repository:
<br>
Ten krok dodaje stworzony pakiet do repozytorium GitHub Packages. Wykorzystywane są token uwierzytelniający (secrets.GHUB_TOKEN) i identyfikator pakietu (package_id). Pakiet jest przypisywany do repozytorium o nazwie "zadanie2".




