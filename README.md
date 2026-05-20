# 🎬 Movies

Um app iOS para descobrir filmes populares, construído com 
SwiftUI e MVI + Clean Architecture.

## 📱 Screenshots
<img width="300" alt="Simulator Screenshot - iPhone Air - 2026-04-16 at 20 50 21" src="https://github.com/user-attachments/assets/1f2456b5-dc53-4c72-961a-17fe762fc679" />
<img width="300" alt="Simulator Screenshot - iPhone Air - 2026-04-16 at 20 47 42" src="https://github.com/user-attachments/assets/0041dc37-8b58-42e9-974f-42730e20459a" />

## 🏛 Arquitetura
- **MVI + Clean Architecture**
- Data → Domain → Presentation
- State, Intent, Store

## 🛠 Tecnologias
- SwiftUI
- Swift Concurrency (async/await)
- URLSession
- NSCache para imagens

## 🧪 Testes
- Swift Testing
- URLProtocolMock para testes de rede
- 65%+ de cobertura

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
