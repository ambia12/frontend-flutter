# Arsitektur Flutter (MVVM) - Starter Project

Dokumen ini menjelaskan struktur arsitektur Model-View-ViewModel (MVVM) yang digunakan pada aplikasi mobile.

## 1. Struktur Layer
- **`app/`**: Berisi konfigurasi global aplikasi, termasuk routing, tema, dan konstanta global.
- **`data/`**: Bertanggung jawab atas pengelolaan sumber data (API, lokal database). Terdiri dari:
  - `models/`: Representasi data objek (DTO).
  - `repositories/`: Implementasi logika komunikasi data dan pengambilan sumber luar.
- **`presentation/`**: Berisi antarmuka pengguna (UI) dan pengelola state (ViewModel/Provider). Terpisah secara ketat dari logika data mentah.
- **`utils/`**: Berisi fungsi bantu global, formatter, dan ekstensi yang bersifat reusable.

## 2. Alur Data (Data Flow) End-to-End
1. **User Action**: Pengguna melakukan aksi di UI (`presentation/`).
2. **ViewModel Interaction**: View memicu fungsi pada ViewModel.
3. **Repository Fetch**: ViewModel meminta data ke Repository (`data/repositories/`).
4. **Data Source & Model**: Repository mengambil data, lalu memetakannya ke Model (`data/models/`).
5. **State Update**: Data dikembalikan ke ViewModel, mengubah state, dan UI merender ulang secara reaktif.