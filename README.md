# 中文 CV

仓库维护面向芯片体系结构与数字 IC/RTL 岗位的中文 CV。

## 构建与检查

需要 XeLaTeX、`latexmk`、Poppler 工具和 `AR PL UMing CN` 字体。

```bash
make clean all
make verify
make render
```

`make verify` 要求 PDF 恰好两页、文字可提取且 LaTeX 日志中没有 overfull box；
`make render` 会将页面输出到 `/tmp/cv_yyj-page-*.png`，供视觉检查使用。

`thesis/` 是只读的嵌套 Git 仓库，仅作为事实来源，不属于本仓库交付物。
