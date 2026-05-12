# MotoEase Branch and Flutter Commit Plan
Dokumen ini dipakai untuk menjelaskan strategi GitHub dan rencana commit pada branch main.

## Git Branch Strategy
Repository MotoEase menggunakan dua branch:
* **main**: source code Flutter mobile app.
* **backend**: source code Node.js Express REST API.

## Workflow branch Flutter:
1. `git checkout main`
2. `git pull origin main`
3. **Commit dan push**:
   ```powershell
   git status
   git add .
   git commit -m "feat: implement motor catalog with BLoC state"
   git push origin main
   ```

## Flutter Commit Plan (10+ Commits)
1. **chore: initialize MotoEase Flutter project** (Setup awal)
2. **chore: add dependencies and premium folder structure** (Setup BLoC, Dio, Lottie)
3. **feat: add glassmorphism and premium UI widgets** (GlassCard, Gradients)
4. **feat: add API service and token storage** (Koneksi Backend)
5. **feat: add user, category, and motor models** (Data Mapping)
6. **feat: add repositories for auth and catalog** (Logic API)
7. **feat: implement auth BLoC and premium login/register screens** (Auth Flow)
8. **feat: implement motor catalog BLoC and list view** (Home Flow)
9. **feat: add motor search with debounce logic** (UX Improvement)
10. **feat: implement motor form with image picker and category selection** (CRUD Add/Edit)
11. **feat: implement category management with bottom navigation** (Category Flow)
12. **style: polish premium automotive UI and animations** (Final Touch)
13. **docs: add MotoEase documentation and presentation guide** (Documentation)
