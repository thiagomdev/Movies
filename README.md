# 🎬 Movies

App iOS para descobrir filmes populares usando a API do TMDB. 
Desenvolvido com SwiftUI, MVI + Clean Architecture, com testes unitários e análise de performance com Instruments.

## 📱 Screenshots
<img width="300" alt="Simulator Screenshot - iPhone Air - 2026-04-16 at 20 50 21" src="https://github.com/user-attachments/assets/1f2456b5-dc53-4c72-961a-17fe762fc679" />

<img width="300" alt="Simulator Screenshot - iPhone Air - 2026-04-16 at 20 47 42" src="https://github.com/user-attachments/assets/0041dc37-8b58-42e9-974f-42730e20459a" />

## 🏛 Arquitetura

```
MVI + Clean Architecture

Clean Architecture
└── Features/
    └── Home/
        ├── Data/
        │   ├── Remote/
        │   └── Repositories/
        ├── Domain/
        │   ├── Models/
        │   ├── Repositories/
        │   └── UseCases/
        └── Presentation/
            ├── MVI/
            └── Views/

MVI
├── State          → único source of truth da UI
├── Intent         → ações possíveis do usuário
└── Store          → processa intents e atualiza o state

Fluxo
View → Intent → Store → UseCase → Repository → DataSource → API → State → View
```

## 🛠 Tecnologias
- SwiftUI
- Swift Concurrency (async/await)
- URLSession
- NSCache para imagens

## 🧪 Testes

```
Swift Testing · URLProtocolMock · 67%+ de cobertura

MoviesTests/
└── Features/
    ├── App/
    │   └── Extensions/
    ├── Core/
    │   └── Network/
    ├── Helpers/
    └── Home/
        ├── Data/
        ├── Domain/
        └── Presentation/
```

## 📂 Estrutura de Pastas

```
Movies/
├── App/
│   ├── Cache/
│   ├── Extensions/
│   ├── Start/
│   └── TMDBConfig/
├── Core/
│   └── Network/
└── Features/
    └── Home/
        ├── Data/
        ├── Domain/
        │   ├── Models/
        │   ├── Repositories/
        │   └── UseCases/
        ├── Factory/
        └── Presentation/
            ├── MVI/
            └── Views/

MoviesTests/
└── Features/
    ├── App/
    │   └── Extensions/
    ├── Core/
    │   └── Network/
    ├── Helpers/
    └── Home/
        ├── Data/
        ├── Domain/
        └── Presentation/
```

## 🚀 Como rodar
1. Clone o repositório
2. Abra o Movies.xcodeproj
3. Rode no simulador
