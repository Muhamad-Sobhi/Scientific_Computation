<div align="center">

# 🧮 Scientific Computation

### A collection of projects for the **Scientific Computation** course

Built with **R** | Each project lives in its own folder

---

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Shiny](https://img.shields.io/badge/Shiny-13849E?style=for-the-badge&logo=rstudio&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

</div>

---

## 📂 Repository Structure

```
Scientific_Computation/
│
├── 📁 R_calculator/          # Project 1: Interactive Calculator
│   ├── main.R                # Shiny app source code
│   └── docker-compose.yml    # Docker setup
│
├── 📁 ...                    # Future projects will be added here
│
└── 📄 README.md
```

> Each project is self-contained in its own directory with all necessary files and instructions.

---

## 🚀 Projects

| #   | Project                            | Description                                                | Tech Stack       |
| --- | ---------------------------------- | ---------------------------------------------------------- | ---------------- |
| 1   | [**R Calculator**](./R_calculator) | A sleek, iOS-style interactive calculator built with Shiny | R, Shiny, Docker |
| 2   | _Coming soon..._                   | —                                                          | —                |

---

## 🛠️ Getting Started

### Prerequisites

- [**R**](https://cran.r-project.org/) (version 4.0+)
- [**RStudio**](https://posit.co/download/rstudio-desktop/) _(recommended)_
- [**Docker**](https://www.docker.com/) _(optional, for containerized projects)_

### Running a Project

1. **Clone the repository**

   ```bash
   git clone https://github.com/Muhamad-Sobhi/Scientific_Computation.git
   cd Scientific_Computation
   ```

2. **Navigate to the project folder**

   ```bash
   cd R_calculator
   ```

3. **Run the project** — choose one method:

   **Option A: Using R directly**

   ```r
   # Install dependencies (first time only)
   install.packages("shiny")

   # Run the app
   shiny::runApp("main.R")
   ```

   **Option B: Using Docker**

   ```bash
   docker-compose up
   ```

---

## 📌 Course Information

| Detail       | Info                   |
| ------------ | ---------------------- |
| **Course**   | Scientific Computation |
| **Language** | R Programming          |
| **Tools**    | RStudio, Shiny, Docker |

---

## 📚 Learning Resources

These are the main resources I used while learning and working with R & Shiny:

| Resource                                                                                                 | Type             |
| -------------------------------------------------------------------------------------------------------- | ---------------- |
| [📖 Mastering Shiny](https://mastering-shiny.org/index.html)                                             | Online Book      |
| [📄 Shiny Cheat Sheet](https://rstudio.github.io/cheatsheets/shiny.pdf)                                  | PDF Reference    |
| [🎥 R For Beginners - بالعربي](https://www.youtube.com/playlist?list=PL1DUmTEdeA6LKTMW3wrlT3GiFMCL_r_Sn) | YouTube Playlist |

---

## 🤝 Contributing

This is a course project repository. Each project is developed as part of course assignments and exercises.

---

<div align="center">

**Made with ❤️ for Scientific Computation**

</div>
