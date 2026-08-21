# 中文 CV 双版本修改计划：Architecture / IC Design

> 执行基线：外层仓库 `cv/zh` 分支的 `edbd963`。`cv_yyj.tex` 是内容基线；
> 已提交的旧 `cv_yyj.pdf` 与源文件不一致，不作为事实或版面基线。
>
> 已确认预计毕业时间：**2026 年 11 月**。

## 0. 任务目标

基于当前中文 CV，制作两份面向不同芯片岗位的 **2 页中文职业简历**：

* Git branch `cv/zh-arch`

  * 面向：

    * SoC Architecture
    * Processor / Microarchitecture
    * Domain-Specific Accelerator
    * FPGA / ASIC Accelerator
    * System Architecture
    * Hardware-Software Co-design
    * Architecture / Performance Analysis

* Git branch `cv/zh-ic`

  * 面向：

    * Digital IC Design
    * RTL Design
    * Front-end Design
    * SoC RTL
    * Processor RTL
    * Accelerator RTL
    * Digital Design / Integration

两份 CV 应共享真实经历，但采用**不同的技术叙事、项目排序、bullet 粒度和技能分类**。

最终要求：

* 两版均严格控制为 **2 页 PDF**
* 允许调整：

  * 页面布局
  * 字体大小
  * 行距
  * 项目间距
  * section 排布
  * bullet 长度
  * 标题格式
  * publication 展示方式
* 不允许为了压缩页数而明显牺牲可读性
* 不允许添加 thesis、现有 CV 或项目材料无法支持的技术经历
* 不允许为了匹配 JD 虚构工具、flow、协议或性能数据

---

# 1. 信息源与优先级

## 1.1 当前 CV

以仓库中当前中文版 CV 为 baseline。

修改过程中应优先保留并重新组织以下经历：

* ASOCA3-FPGA
* ENGINE（可重构 FPGA 双可寻址存储器）
* ASOCA Infrastructure Development Environment
* ASOCA3 system interfaces / AIDE
* ASOCA2
* FPGA Comms
* ASOCat
* ReMap
* 分层 SRAM–Flash 存储管理机制
* CoNM RV32I CPU

以下内容根据目标岗位压缩或删除：

* ATLAS
* Saliency detector
* 非技术性兴趣爱好
* 与目标岗位关联较低的早期研究经历
* 过长的 publication 信息

---

## 1.2 Thesis

博士 thesis 位于：

```text
./thesis
```

该目录为一个 **nested Git repository**。

### 使用原则

将 thesis 作为 CV 技术细节的主要事实来源之一，用于确认：

* ASOCA3 architecture
* processing-core microarchitecture
* ISA
* graph/database workload mapping
* data representation
* memory architecture
* accelerator organisation
* NoC / system integration
* FPGA implementation
* evaluation methodology
* performance/resource results
* ASOCA2 architecture
* associative / dually-addressable memory
* RTL implementation details
* hardware/software interface

### Git 安全要求

`./thesis` 必须视为**只读参考仓库**。

禁止：

```bash
git add thesis
git add thesis/*
git commit thesis
git clean -fd thesis
git reset --hard -- thesis
```

不要修改：

```text
./thesis/.git
```

不要在 CV 分支操作过程中改变 thesis repo 的 branch、HEAD 或工作区状态。

如需查看 thesis Git 信息，使用：

```bash
git -C ./thesis status
git -C ./thesis log
```

但不要产生写操作。

---

## 1.3 信息可信度层级

修改 CV 时，事实依据优先级为：

1. 原始代码、实现报告、测试记录和明确的个人贡献声明
2. Thesis 中明确记录的设计、结果与贡献边界
3. 当前 CV 中明确陈述、且不与以上资料冲突的事实
4. 从上述信息可以直接推导出的保守表述

当前 CV 仅作为经历索引，不作为最高等级证据。发生冲突时，以更接近原始实现、
测量和贡献记录的资料为准；无法消解的冲突必须降级表述或标为 `TODO-VERIFY`。

事实台账除技术事实外，还必须记录：

```text
Personal ownership
Team/system context
Measurement type: measured / estimated / analytical
Required qualifier
```

禁止：

* 根据典型 ASIC flow 推测本人一定做过某一步
* 因为使用 Synopsys 就自动写成会 PrimeTime / Design Compiler
* 因为使用 SystemVerilog 就自动写成有 SVA / UVM coverage 经验
* 因为做过 PCIe integration 就自动写成实现过 PCIe controller
* 因为项目成功流片就自动写成负责 physical design / STA / DFT
* 未找到证据时虚构 PPA、频率、面积、功耗、coverage 等数字

若某项能力可能存在但证据不足，应标记：

```text
TODO-VERIFY
```

而不是直接写入最终 CV。

---

# 2. Git 工作流

## 2.1 开始前

首先检查：

```bash
git status
git branch --show-current
git log -5 --oneline
git -C ./thesis status
```

记录当前 CV baseline 所在 commit。

不要改变 `./thesis` 工作区。

外层仓库必须忽略 `/thesis/`。禁止使用 `git add .` 或 `git add -A`；只允许按文件白名单暂存：

```bash
git add -- PLAN.md .gitignore README.md Makefile cv_yyj.tex resume.cls cv_yyj.pdf
git diff --cached --name-only
```

若暂存区出现 `thesis`、临时笔记或构建缓存，立即停止并移出暂存区。

---

## 2.2 Architecture 版本

创建或切换：

```bash
git switch cv/zh-arch
```

如果分支尚不存在：

```bash
git switch -c cv/zh-arch <baseline>
```

仅修改 Architecture 版 CV 所需文件。

完成后：

1. build PDF
2. 确认恰好 2 页
3. 检查排版
4. 检查内容准确性
5. 检查 git diff

---

## 2.3 IC Design 版本

从同一个 baseline 创建：

```bash
git switch cv/zh-ic
```

如果分支尚不存在：

```bash
git switch -c cv/zh-ic <baseline>
```

不要从已经大幅修改后的 `cv/zh-arch` 直接派生，除非仅 cherry-pick：

* 联系方式修正
* Expected Graduation
* 拼写修正
* 通用排版 bugfix

两个分支的项目 bullet 应允许明显分叉。

---

# 3. 两版共享修改

以下修改应在两个版本中都完成。

---

## 3.1 明确预计毕业时间

当前：

```text
2022 年 9 月 – 至今
```

修改为：

```text
2022 年 9 月 – 预计 2026 年 11 月
```

该时间已由本人确认。

---

## 3.2 教育经历压缩

教育部分只保留招聘相关信息：

### University of Edinburgh

保留：

* PhD Candidate in Engineering
* 预计毕业时间
* 研究方向
* 全额奖学金

导师姓名视空间决定是否保留。

### NTU

保留：

* MSc (Electronics)
* 时间
* 地点

### 同济

保留：

* 电子科学与技术
* 工学学士
* 时间
* 地点

不再展开课程。

---

## 3.3 项目 bullet 写作规则

核心项目 bullet 应遵循：

```text
Action + Technical object + Method / architecture + Result / purpose
```

避免：

```text
负责……
参与……
开展……
进行了……
```

优先使用：

```text
设计
实现
定义
开发
集成
验证
搭建
优化
评估
主导
```

每条 bullet 至少包含一个可识别的技术对象，例如：

```text
processing core
ISA
datapath
control logic
pipeline
memory subsystem
NoC
PCIe
RTL
UVM environment
memory controller
accelerator
benchmark framework
```

---

## 3.4 定量结果

检查 thesis 和其他材料，尽可能为核心项目补充真实定量信息。

优先级：

1. frequency
2. throughput
3. latency
4. bandwidth
5. LUT / FF / BRAM / DSP
6. speed-up
7. area
8. power
9. technology node
10. number of cores
11. module count
12. test / coverage result

数字必须可追溯，并明确是本人结果、团队系统结果、测量值、实现估算还是分析模型。

如果结果存在，但上下文复杂，不要为了漂亮而过度简化。

---

## 3.5 兴趣爱好

当前技术求职 CV 中兴趣内容最多保留一行。

优先删除：

```text
Geek culture
鸡尾酒
卡夫卡
绿日
Minesweeper
```

如果 2 页空间紧张，全部删除。

---

# 4. `cv/zh-arch` 修改方案

## 4.1 目标候选人画像

完成后，招聘者应能在约 20–30 秒内形成以下判断：

> 具有 FPGA/ASIC 落地经验的专用加速器与处理器微架构 PhD，具有 ISA、processing core、memory architecture、NoC/PCIe interface specification、FPGA accelerator system 和 hardware/software co-design 经验。

禁止让主要印象变成：

> 图数据库研究人员，会一些 FPGA。

---

# 4.2 Architecture 版内容结构

推荐顺序：

```text
姓名 / 联系方式
Technical Profile
教育背景
核心项目 / 研究经历
论文发表
专业技能
```

如果版面更适合，也可：

```text
姓名 / 联系方式
教育背景
Technical Profile
核心项目
专业技能
论文
```

重点是核心项目必须出现在第一页上半部分。

---

# 4.3 Technical Profile

增加一个极短 section。

建议涵盖：

```text
Processor Microarchitecture
Domain-Specific Accelerator
ISA Design
Memory Architecture
NoC / PCIe
FPGA / ASIC Prototyping
Hardware-Software Co-design
```

不要加入未经证实的：

```text
GPU architecture
CUDA
SystemC
gem5
GPGPU-Sim
```

---

# 4.4 项目排序

优先级建议：

## Tier 1 — 必须重点展开

1. ASOCA3-FPGA
2. ENGINE
3. ASOCA2
4. CoNM

## Tier 2 — 适度保留

5. ASOCA Infrastructure / system interfaces
6. 分层 SRAM–Flash 存储管理
7. FPGA Comms
8. ASOCat

## Tier 3 — 压缩或删除

9. ReMap
10. Saliency detector
11. ATLAS

最终每版最多保留 5–6 个项目；Tier 2 只择优保留 1–2 个，而不是全部收入。
项目 bullet 总量以 14–16 条为目标。任何新增内容必须通过删除低价值项目或重复信息获得空间。

---

# 4.5 ASOCA3-FPGA

这是 Architecture 版第一核心项目。

当前抽象描述必须扩展成具体 architecture 内容。

从 thesis 中重点提取：

```text
workload model
graph operation primitives
ISA definition
instruction format
processing-core organisation
datapath
control
execution model
pipeline
memory organisation
local/global memory
task scheduling
data scheduling
inter-core communication
NoC
scalability
host interface
performance evaluation
resource utilisation
```

最终建议保留 3–4 条 bullet。

目标结构：

### Bullet A — Architecture / workload

解释：

```text
针对什么 workload
提出/设计什么 accelerator architecture
解决什么问题
```

### Bullet B — ISA / processing core

解释：

```text
如何定义 ISA
processing core 有什么组织
哪些操作映射到硬件
```

### Bullet C — Memory / communication

解释：

```text
memory subsystem
NoC
core-to-core / core-to-memory communication
```

### Bullet D — Evaluation

如果存在真实结果：

```text
frequency
throughput
resource
speed-up
scalability
```

---

# 4.6 ASOCA2

Architecture 版强调：

```text
associative / dually-addressable memory
graph accelerator architecture
memory organisation
hardware mapping
ASIC prototype
scalability
```

同时保留：

```text
成功流片
```

但不要让 tapeout 抢走全部叙事。

最终 2–3 bullet。

---

# 4.6A ENGINE

这是候选人独立完成的 FPGA 双可寻址存储器项目，可用于直接证明 memory architecture、
RTL、FPGA implementation 与资源/延迟权衡能力。Architecture 版重点展示：

```text
BRAM-based dually-addressable memory
content/address dual access without data duplication
memory mapping and parallel search organisation
100% BRAM storage efficiency
resource, frequency and analytical latency bounds with explicit qualifiers
```

---

# 4.7 ASOCA3 system interfaces / AIDE

这一部分应从现在的辅助性质经历升级，但必须区分个人贡献与团队系统背景。

重点提取：

```text
NoC traffic requirements
ASOCA64 flit specification
processing-core-side handshaking interface
team-developed NoC / PCIe subsystem context
data movement
system integration
accelerator composition
vector database accelerator
DRAM-based dually-addressable memory
architecture reuse
```

Architecture 版强调：

```text
system architecture leadership
communication requirements
packet/flit specification
core-to-network interface
scalability constraints
```

不得声称本人实现了最终 NoC、PCIe 子系统、顶层 FPGA 集成或硬件结果采集；这些由其他项目成员完成。

---

# 4.8 CoNM

本科项目虽然较早，但与目标岗位高度相关。

重点确认：

```text
RV32I
four-stage pipeline
static branch prediction
hazard detection
forwarding
stall
flush
register file
ALU
control unit
memory interface
FPGA implementation
```

若实际做过，应具体化。

目标是使其成为明确的：

```text
processor microarchitecture evidence
```

而不是简单“写过一个 RISC-V”。

---

# 4.9 ASOCA Infrastructure

Architecture 版弱化 UVM，强化：

```text
performance evaluation
benchmarking
workload generation
Neo4j
Memgraph
reference implementation
architecture comparison
```

重点尝试证明：

```text
本人具有 architecture performance evaluation 能力
```

如果 thesis / repo 中没有足够证据，不夸大为：

```text
cycle-accurate modelling
```

---

# 4.10 SRAM–Flash 项目

将项目重新定位为：

```text
memory hierarchy / memory-management hardware
```

重点：

```text
SRAM–Flash hierarchy
page replacement
controller/interface
MCU integration
```

如果实现了硬件状态机、地址映射或 replacement policy，应明确。

---

# 4.11 ASOCat

仅保留与以下方向有关的内容：

```text
hardware/software interface
graph representation
associative memory
procedural-memory hardware exploration
```

Copycat / cognitive model 背景应压缩。

---

# 4.12 Publications

Architecture 版保留三篇核心论文：

```text
Views
A Resource-efficient Dually-addressable Memory Architecture on FPGA
ASOCA2 / A Modular Graph Database Accelerator
```

重点表现：

```text
architecture relevance
```

可以考虑取消完整作者列表。

格式建议：

```text
论文名 — venue, year
短技术标签
```

例如：

```text
Views ... — arXiv, 2025 | Graph representation / accelerator architecture
```

技术标签必须与论文实际内容相符。

AP-S/URSI 2020 论文可删除。

---

# 4.13 Architecture Skills

不要继续仅列：

```text
SystemVerilog
Python
Synopsys
Vivado
...
```

建议重新分类：

```text
体系结构：
Processor microarchitecture, ISA design, domain-specific accelerator,
memory architecture, NoC, PCIe, FPGA/ASIC prototyping

硬件与编程：
SystemVerilog/Verilog, Python, C/C++, Bash, Tcl

工具：
按真实使用情况列具体工具
```

如果工具只确认到厂商级名称，不要擅自展开具体产品。

---

# 5. `cv/zh-ic` 修改方案

## 5.1 目标候选人画像

完成后，招聘者应迅速形成以下判断：

> 具有真实 ASIC tapeout、processor RTL、accelerator RTL、SystemVerilog、verification、FPGA implementation 和数字系统接口定义经历的数字 IC / RTL 候选人。

禁止让第一印象是：

> 一个 architecture PhD，可能也会写 RTL。

---

# 5.2 IC 版推荐结构

```text
姓名 / 联系方式
Technical Profile
教育背景
数字 IC / RTL 项目经历
专业技能
Selected Publications
```

论文必须明显弱于项目。

---

# 5.3 Technical Profile

候选关键词仅在真实经历支持时使用：

```text
Digital IC Design
RTL Design
SystemVerilog / Verilog
Processor RTL
Accelerator RTL
SoC Integration
Functional Verification
custom compliance verification / UVM-inspired methodology
FPGA Prototyping
ASIC Tapeout
```

下列内容必须从 thesis / repo 确认后才能写：

```text
Lint
CDC
RDC
Synthesis
STA
SDC
Formal
Gate-level simulation
PPA optimisation
DFT
```

---

# 5.4 项目排序

建议：

## Tier 1 — 必须重点展开

1. ASOCA2
2. ASOCA3-FPGA
3. ENGINE
4. CoNM

## Tier 2

5. ASOCA Infrastructure / ASOCA3 interfaces
6. ReMap
7. FPGA Comms
8. SRAM–Flash

## Tier 3

9. ASOCat
10. Saliency detector
11. ATLAS

ATLAS 原则上删除。

---

# 5.5 ASOCA2

这是 IC Design 版最关键经历。

从 thesis / repo 中尽可能提取以下事实：

```text
implemented RTL modules
module responsibility
datapath
control logic
FSM
memory interface
bus/interface
arbitration
clock/reset
parameterised design
verification
testbench
SystemVerilog
UVM
assertion
coverage
regression
synthesis
timing
lint
CDC
ASIC handoff
tapeout
post-silicon test
```

最终建议 3–4 bullet。

最低必须明确：

1. 芯片是什么
2. 本人负责哪些数字模块
3. 如何验证
4. 成功 tapeout；开展 post-silicon 测试与故障分析，但不得写成成功完成硅后功能验证

不要仅保留：

```text
负责核心数字硬件开发与验证
```

这是目前最需要消除的模糊表达之一。

---

# 5.6 ASOCA3-FPGA

IC 版不重点讲：

```text
为什么设计这种 architecture
```

而重点讲：

```text
实现了哪些 RTL
模块如何组成
接口是什么
如何验证
如何综合 / FPGA implementation
```

从 thesis / RTL repo 中确认：

```text
processing core RTL
datapath
control
pipeline
memory module
NoC interface
top-level integration
parameterisation
clock/reset
synthesis result
FPGA timing
resource utilisation
```

---

# 5.6A ENGINE

IC 版将其作为候选人独立完成的 parameterised memory RTL 证据，重点展示：

```text
decoder / RAMB / comparison and control datapath
BRAM primitive mapping
content-addressable and address-addressable operation
multi-device FPGA verification
resource utilisation and implemented frequency
```

---

# 5.7 CoNM

将其定位为：

```text
complete processor RTL design
```

而不仅是 CPU architecture project。

确认并突出真实完成的：

```text
pipeline registers
hazard unit
forwarding
branch control
register file
ALU
decoder
memory interface
FPGA synthesis
implementation
verification
```

建议 2–3 bullet。

---

# 5.8 ASOCA Infrastructure

IC 版重点强化：

```text
custom compliance verification
UVM-inspired methodology
verification environment
automation
regression
reference model
driver
monitor
scoreboard
sequence
coverage
```

但每个关键词必须通过 repo / thesis / code 确认。

Thesis 证据表明该环境借鉴 UVM 的 sequencer/monitor/scoreboard 分层，但不是标准 UVM 环境。
除非另有代码证据，不得写成“基于 UVM”或完整 UVM ownership。

---

# 5.9 ASOCA3 interfaces

IC 版重点从 architecture 转成：

```text
NoC traffic requirements
ASOCA64 flit specification
SC-side RTL handshake interface
system interface definition
```

AXI-Lite、PCIe Gen3 x16、BAR0/MMIO 等只可作为团队系统的接口背景；不得据此声称本人实现或集成了相关子系统。

不要根据 SoC 常识自动加入 AXI。

---

# 5.10 ReMap

Architecture 版可以弱化，但 IC 版值得重新检查。

重点寻找：

```text
fixed-point arithmetic
binary logarithm
datapath
combinational/sequential implementation
pipeline
RTL
synthesis
area
timing
power
accuracy/hardware trade-off
```

如果这些内容在 dissertation 中确实存在，可作为：

```text
arithmetic datapath design / optimisation
```

项目保留。

---

# 5.11 SRAM–Flash

IC 版重点：

```text
controller
interface logic
FSM
page replacement hardware
memory control
MCU integration
```

Architecture motivation 压缩。

---

# 5.12 Publications

改为：

```text
Selected Publications
```

只留最相关 2–3 篇。

建议：

* ISCAS 2025
* ASOCA2 / ECML-PKDD 2024
* Views 视空间决定

删除 AP-S/URSI。

不列详细作者。

论文整体不应占超过约 10–15% 页面面积。

---

# 5.13 IC Skills

目标结构：

```text
RTL：
SystemVerilog / Verilog, RTL design, processor/accelerator datapath & control

Verification：
UVM / simulation / regression / etc.
仅列实际做过项目

Digital Front-end：
synthesis / STA / CDC / lint / SDC / etc.
逐项核实后加入

Interfaces：
NoC, PCIe，以及实际使用过的具体 on-chip bus

Programming：
Python, Tcl, Bash, C/C++

EDA：
使用具体工具名，而不是只有 Synopsys / Cadence 厂商名
```

重点检查现有项目和 thesis 是否能确认：

```text
VCS
Verdi
Design Compiler
PrimeTime
SpyGlass
Xcelium
Genus
Questa/ModelSim
Vivado
```

没有明确证据就不写。

---

# 6. Thesis 信息提取任务

在正式重写 bullet 前，先完成一次 thesis mining。

不要边读边直接修改 CV。

先生成临时工作笔记，例如：

```text
/tmp/cv-thesis-notes.md
```

该文件不应提交。

建议建立如下表格：

| Project       | Architecture facts | RTL facts | Verification facts | Tools | Interfaces | Quantitative results | Source |
| ------------- | ------------------ | --------- | ------------------ | ----- | ---------- | -------------------- | ------ |
| ASOCA3        |                    |           |                    |       |            |                      |        |
| ASOCA2        |                    |           |                    |       |            |                      |        |
| ENGINE        |                    |           |                    |       |            |                      |        |
| ASOCA3 interfaces / AIDE |         |           |                    |       |            |                      |        |

其中 `Source` 必须记录：

```text
chapter
section
figure/table
source file
```

便于之后检查 CV 是否夸大。

---

# 7. Bullet 生成流程

对每个核心项目执行以下流程。

## Step 1 — 事实提取

列出所有可以被材料支持的：

```text
architecture
microarchitecture
RTL
verification
implementation
results
```

## Step 2 — 分类

标记：

```text
[ARCH]
[IC]
[BOTH]
[LOW]
```

## Step 3 — Architecture draft

每个核心项目生成最多 4 个候选 bullet。

## Step 4 — IC draft

独立生成最多 4 个候选 bullet。

不要机械改几个名词。

## Step 5 — 去重

删除项目间重复表达，例如：

```text
负责架构设计
完成 FPGA 验证
参与系统集成
```

必须让每个项目承担不同的证明责任。

---

# 8. 两版项目“证明责任”

## Architecture 版

| 项目             | 主要证明内容                                                |
| -------------- | ----------------------------------------------------- |
| ASOCA3         | Accelerator + ISA + processing-core microarchitecture |
| ENGINE         | Dually-addressable memory architecture + FPGA implementation |
| ASOCA2         | ASIC accelerator + specialised memory architecture    |
| ASOCA3 interfaces | NoC traffic / flit specification / core-side interface |
| CoNM           | General-purpose processor microarchitecture           |
| Infrastructure | Performance evaluation methodology                    |
| SRAM–Flash     | Memory hierarchy                                      |
| ASOCat         | HW/SW co-design                                       |

---

## IC 版

| 项目             | 主要证明内容                            |
| -------------- | --------------------------------- |
| ASOCA2         | ASIC RTL + verification + tapeout |
| ASOCA3         | Complex accelerator RTL           |
| ENGINE         | Parameterised memory RTL + FPGA implementation |
| CoNM           | Processor RTL                     |
| Infrastructure | Custom compliance / verification methodology |
| ASOCA3 interfaces | RTL interface specification               |
| ReMap          | Arithmetic datapath               |
| SRAM–Flash     | Memory controller / control logic |

---

# 9. 排版优化

允许重新设计 PDF 排版，但最终必须保持专业、克制。

优先通过以下方式获得空间：

1. 删除低价值内容
2. 压缩重复 bullet
3. 压缩 publications
4. 减少 section vertical whitespace
5. 优化左右 margin
6. 优化 bullet indentation
7. 合并低价值信息

最后才考虑减小字号。

---

## 9.1 可读性底线

不要：

* 将正文压到明显难以阅读的字号
* 极端缩小页边距
* 使用过密的行距
* 一行堆叠过多技术关键词
* 使用 4–5 行的单个 bullet
* 让第二页只有少量内容
* 通过 scale 整页 PDF 强制缩成 2 页

---

## 9.2 页面目标

理想状态：

### Page 1

* 姓名 / 联系方式
* Profile
* Education
* 1–3 个最重要项目

### Page 2

* 剩余项目
* Skills
* Publications

第一页必须包含该版本最核心的专业证据。

---

# 10. PDF Build 与验证

识别现有 CV build system，并优先沿用。

除非当前系统严重限制双版本维护，否则不要无必要迁移工具链。

固定使用 XeLaTeX，并提供仓库内 `Makefile`。每次主要修改后执行完整 build。

版面基线固定为 US Letter；若改为 A4，必须在两版同时修改并重新验收。正文不得依赖无效的
`9pt` class 选项，且不得进一步缩小当前 0.5 英寸左右页边距与 0.25 英寸下边距。

最低自动检查：

```bash
make clean all
pdfinfo cv_yyj.pdf
pdftotext -layout cv_yyj.pdf -
pdffonts cv_yyj.pdf
rg 'Overfull|LaTeX Error' cv_yyj.log
```

随后将两页渲染为图片并进行视觉检查。

验证：

```text
PDF 是否成功生成
页数 == 2
无 overflow
无 clipped text
无 orphan heading
无错误换行
无乱码
无超长 URL
字体一致
section spacing 一致
```

---

# 11. 内容 QA

最终逐条检查。

## Architecture 版

回答以下问题：

* 是否第一页明确出现 microarchitecture？
* 是否明确出现 ISA？
* 是否明确出现 accelerator architecture？
* 是否体现 memory / NoC / SoC？
* 是否有真实 FPGA/ASIC 落地证据？
* 是否体现 performance evaluation？
* 是否避免被看成纯数据库研究者？

---

## IC 版

回答：

* 是否第一页明确出现 RTL？
* 是否明确出现 SystemVerilog/Verilog？
* 是否明确出现 ASIC tapeout？
* 是否明确说明本人实现了什么数字逻辑？
* 是否出现 verification？
* 是否体现 processor RTL？
* 是否体现 SoC integration？
* 是否只将可证明为本人使用的 front-end flow 写具体？
* 是否避免被看成只做 architecture 的研究人员？

---

# 12. 真实性 QA

对以下高风险关键词逐项确认来源：

```text
microarchitecture
ISA
RTL
UVM
SVA
coverage
lint
CDC
RDC
synthesis
STA
SDC
PPA
timing closure
PCIe
AXI
NoC
post-silicon
tapeout
```

同时逐项检查以下高风险边界：

```text
ASOCA3 必须描述为 FPGA accelerator system，而不是 SoC
最终 NoC / PCIe / top-level integration / hardware-result capture 属于团队背景
AIDE 是 custom、UVM-inspired compliance environment，不是标准 UVM 环境
ASOCA2 可写成功流片，但 post-silicon functional validation 未成功
系统级资源与时序结果不得暗示为本人独立实现或测量
```

分类：

```text
CONFIRMED
UNSUPPORTED
AMBIGUOUS
```

最终 CV 只能保留：

```text
CONFIRMED
```

`AMBIGUOUS` 必须改为更保守表述。

---

# 13. Diff Review

完成两版后，比较：

```bash
git diff <baseline>..cv/zh-arch
git diff <baseline>..cv/zh-ic
git diff cv/zh-arch..cv/zh-ic
```

最后一个 diff 应显示：

* 项目优先级明显不同
* bullet 明显不同
* skills 明显不同
* publication 权重不同

如果两版只有少量关键词变化，则拆分失败，需要重新修改。

上述 branch diff 只在完成提交后执行。每个分支必须在最终 QA 后形成独立 commit，并确认：

```bash
git status --short
git show --stat --oneline HEAD
```

---

# 14. 最终验收标准

## `cv/zh-arch`

必须满足：

* [ ] PDF 恰好 2 页
* [ ] 明确 Expected Graduation
* [ ] ASOCA3 是核心项目
* [ ] ISA / microarchitecture / accelerator 明确可见
* [ ] Memory / NoC traffic / PCIe interface context 等系统级能力得到体现
* [ ] 有 FPGA/ASIC implementation 证据
* [ ] Performance evaluation 能力得到体现
* [ ] Publications 与 architecture narrative 一致
* [ ] 不虚构 GPU/SystemC/gem5/CUDA 等经验
* [ ] 招聘者无需自行推导本人属于 Architecture candidate

## `cv/zh-ic`

必须满足：

* [ ] PDF 恰好 2 页
* [ ] 明确 Expected Graduation
* [ ] ASOCA2 tapeout 是核心证据
* [ ] 明确本人负责的 RTL 内容
* [ ] SystemVerilog/Verilog 明确可见
* [ ] CoNM 被呈现为 processor RTL 项目
* [ ] Custom compliance / verification 经核实后明确展示
* [ ] NoC/PCIe interface contribution 与团队集成边界准确展示
* [ ] EDA/front-end flow 使用具体、真实工具和流程
* [ ] Publications 被压缩
* [ ] 招聘者无需自行推导本人具有 IC Design 能力

---

# 15. 最终交付物

两个 Git branches：

```text
cv/zh-arch
cv/zh-ic
```

每个 branch 应包含：

```text
CV source
可重复执行的 build 配置
最终 2-page PDF
```

不要提交：

```text
temporary thesis notes
build cache
thesis repo modifications
unrelated files
```

最终分别记录：

```text
branch
commit hash
PDF path
page count
```

并提供一个简短总结：

### Architecture

```text
3–5 条最主要修改
仍存在但未能从材料确认的技能缺口
```

### IC Design

```text
3–5 条最主要修改
仍存在但未能从材料确认的技能缺口
```

---

# 16. 核心原则

整个任务始终遵守以下原则：

> Architecture 版回答：“为什么这样设计，以及系统如何工作？”

> IC Design 版回答：“本人具体实现、验证和交付了什么数字硬件？”

两版可以引用相同项目，但不能讲同一个故事。

所有修改以提高**岗位特异性、技术可验证性和首屏可识别性**为目标，而不是单纯增加关键词。
