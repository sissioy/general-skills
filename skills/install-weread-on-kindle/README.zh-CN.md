# Kindle 觅阅安装 Skill

`install-weread-on-kindle` 面向希望在 Kindle 上使用[觅阅 MiuRead](https://github.com/miumiupy98-art/miuread-koreader) 的用户和维护者。它把设备识别、版本兼容性检查、越狱/启动器选择、KOReader 与觅阅安装、可选功能配置、验收和回滚整理成一条稳定优先的落地流程。

## 适用范围

- Kindle Paperwhite 3（PW3/KPW3）：适用于已验证的 WinterBreak2 + KUAL/MRPI 旧版环境。
- Kindle Paperwhite 4（PW4/KPW4）：适用于已验证的 Sanctuary + KMC/KPM 环境。
- KOReader 与 MiuRead/觅阅插件模式，用于授权账号、打开“我的书架”、下载和阅读书籍。
- 一键启动 KOReader、自动打开觅阅书架、KOReader 内置下划线、翻页动画，以及 Kindle 官方风格休眠画面等可选配置。
- 已有安装的诊断、兼容性审计、故障排查和最小范围回滚。

不适用于：未经核实的 Kindle 型号/固件组合、未知网盘整合包、把 KUAL/MRPI 与 Sanctuary/KPM 混装，或要求无条件升级/降级固件的场景。固件、越狱入口和插件版本会变化，社交平台教程只能作为线索，不能替代上游发布页校验。

## 相关项目与正确来源

本仓库不是下列项目的发布源，也不提供第三方安装包镜像。安装前应重新打开相应的上游页面，核对设备、固件、版本和校验值。

| 项目 | 在本 Skill 中的用途 | 官方来源 |
|---|---|---|
| 觅阅 MiuRead | KOReader 上的阅读、书架、下载、划线与进度功能 | [源代码](https://github.com/miumiupy98-art/miuread-koreader) · [正式版本](https://github.com/miumiupy98-art/miuread-koreader/releases) |
| KOReader | Kindle 阅读器与觅阅插件宿主 | [源代码](https://github.com/koreader/koreader) · [正式版本](https://github.com/koreader/koreader/releases) · [Kindle 安装说明](https://github.com/koreader/koreader/wiki/Installation-on-Kindle-devices) |
| KindleModding 文档 | 越狱、后续环境与 OTA 操作的上游说明 | [官方文档](https://kindlemodding.org/) · [文档源代码](https://github.com/KindleModding/kindlemodding.github.io) |
| WinterBreak2 | 已验证 PW3 旧固件路线的越狱入口 | [官方指南](https://kindlemodding.org/jailbreaking/WinterBreak2/) · [源代码](https://github.com/KindleModding/Winterbreak2) |
| Sanctuary | 已验证 PW4 5.18.1 路线的越狱与 KPM 入口 | [官方指南](https://kindlemodding.org/jailbreaking/Sanctuary/) |
| Universal Hotfix | 旧版越狱路线的固化环境 | [源代码](https://github.com/KindleModding/Hotfix) · [正式版本](https://github.com/KindleModding/Hotfix/releases) · [官方安装指南](https://kindlemodding.org/jailbreaking/Legacy/post-jailbreak/setting-up-a-hotfix/) |
| PEKI / KUAL | 旧版路线的 KUAL 安装与启动入口 | [PEKI 源代码](https://github.com/KindleModding/PEKI) · [KUAL/MRPI 官方指南](https://kindlemodding.org/jailbreaking/Legacy/post-jailbreak/installing-kual-mrpi/) |
| MRPI | 旧版路线的 Kindle 更新包安装器 | [KUAL/MRPI 官方指南](https://kindlemodding.org/jailbreaking/Legacy/post-jailbreak/installing-kual-mrpi/) |
| `renameotabin` / OTA 禁用 | 防止越狱后自动更新固件 | [OTA 禁用官方指南](https://kindlemodding.org/jailbreaking/Legacy/post-jailbreak/disable-ota.html) |
| KPM / KMC 环境 | Sanctuary 路线的软件包管理与启动 | [KPM 源代码](https://github.com/KindleModding/KPM) · [KPM 文档](https://kindlemodding.org/kindle-dev/kpm/) · [官方软件包目录](https://github.com/KindleModding/repo) |
| KOReader 的 KPM 包 | Sanctuary 路线使用的 KOReader 软件包 | [KindleModding KOReader 包源](https://github.com/KindleModding/koreader) · [官方 KPM 清单](https://github.com/KindleModding/repo/blob/main/manifest.v2.json) |
| Swipe Animation | KOReader 翻页动画覆盖层 | [源代码与版本](https://github.com/MsReverie/Swipe_Animation.koplugin) |

`assets/patches/` 中的自动书架与休眠画面脚本属于本 Skill 的配套补丁，并非上述项目的官方发行文件；使用前须按 `references/customizations.md` 的版本边界检查。

## 落地主要步骤

1. **确认目标和设备**：从 Kindle“设备信息”读取准确型号与固件，明确是否需要一键启动、自动书架、原生锁屏、下划线或翻页动画。
2. **只读审计与备份**：退出 KOReader 后连接 USB，审计可见分区布局；备份隐藏目录、`documents`、KOReader 设置和现有插件，生成文件清单与 SHA-256 校验值，不记录完整序列号或觅阅凭据。
3. **核对上游兼容性**：根据型号/固件确认越狱是否支持、是否必须更新、启动器栈和 OTA 禁用方式；先固定组合，再下载作者原始包并记录版本、来源和哈希。
4. **执行对应设备路线**：PW3 走 WinterBreak2 → Universal Hotfix → KUAL/MRPI；PW4 走 Sanctuary → KMC/KPM。每一步都等待屏幕结果，失败就停在当前检查点，不叠加重试或恢复出厂。
5. **安装阅读核心**：安装匹配的 KOReader 包和完整 `miuread.koplugin`，由用户在 Kindle 上完成微信授权；验证觅阅书架、下载、打开书籍和阅读进度保存。
6. **逐层加入可选功能**：按“一键启动 → 自动书架 → 官方休眠画面 → 内置下划线 → 翻页动画”的顺序逐项备份、安装和验证，避免一次覆盖多个核心目录。
7. **验收与交付**：确认原生 Kindle 阅读仍可用，KOReader 能启动/退出，休眠唤醒回到正确页面，自动书架行为符合预期，Wi‑Fi 下没有 OTA 临时更新文件，并保存最终版本、路径、哈希和回滚备份。

## 稳定性边界

- 默认保留当前可用固件，不主动升级、降级、注销账号或恢复出厂。
- 越狱后优先禁用 OTA；不要把旧版 KUAL/MRPI 包安装到 Sanctuary/KPM 设备。
- 任何 USB 写入前退出 KOReader；任何异常优先移除对应插件或恢复备份，不动原生系统。

详细的版本矩阵、设备路线、补丁和故障处理见同目录的 `references/` 与 `assets/`。
