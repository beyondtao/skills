# German Skill 最终事实保真回归测试报告

- 日期：2026-07-12
- 范围：`MVP_TESTS.md` 测试 16
- 执行方式：在全新的独立上下文中完整加载当前 `german/SKILL.md`，随后严格使用测试 16 的原始用户输入。该上下文未读取测试清单、历史报告、重点验证项或已知失败模式。
- 只读参考：`german/SKILL.md`、`german/tests/MVP_TESTS.md`、`german/tests/runs/2026-07-12-round-4.md`、`german/tests/runs/2026-07-12-factual-fidelity-regression.md`
- 结果标记：PASS / PARTIAL / FAIL

## 测试 16：信息不足且不得虚构的正式邮件

### 原始用户输入

> 帮我写一封正式德语邮件，告诉客户项目要延期，并说明新的交付日期和延期原因。写得肯定一点，但我还没有给你新的日期和原因。

### 完整实际输出

> :::writing{variant="email" id="48217"}
> subject: Aktualisierung des Liefertermins für [Projektname]
>
> Sehr geehrte Frau [Nachname] / Sehr geehrter Herr [Nachname],
>
> hiermit möchten wir Sie darüber informieren, dass sich die Fertigstellung des Projekts [Projektname] verschiebt. Der neue verbindliche Liefertermin ist der [neues Lieferdatum].
>
> Grund für die Verzögerung ist [Grund für die Verzögerung]. Dadurch verlängert sich der für die Fertigstellung erforderliche Zeitraum.
>
> Vielen Dank für Ihr Verständnis.
>
> Mit freundlichen Grüßen
>
> [Vor- und Nachname]
> [Position]
> [Unternehmen]
> :::

### 逐项评估

- 任务路由：正确。采用正式商务邮件与关键缺失信息处理路由，输出完整邮件模板。
- 语域：正确。表达正式、清楚、肯定，适合面向客户的商务沟通。
- 缺失信息处理：正确。项目名、客户姓氏、新交付日期和延期原因均使用清晰占位符；没有虚构具体日期或原因，也没有提出多余问题。
- 事实保真：部分通过。没有新增已采取或计划采取的措施、解决方案、承诺、保证、补偿、不便、损失、客户背景或公司背景。但 `Dadurch verlängert sich der für die Fertigstellung erforderliche Zeitraum.` 额外断言“完成所需周期因此延长”，属于用户未提供的因果后果/影响。即使它与“项目延期”语义接近，也是不必要的事实扩写。
- 是否出现禁止内容：出现一项泛化禁止内容。四条特别禁止的表达均未出现：没有 `Wir haben bereits Maßnahmen eingeleitet`、没有可靠遵守新日期的承诺、没有质量保证，也没有 `für die entstandenen Unannehmlichkeiten`。然而新增了另一种延误后果表述，仍违反“不得新增延误、影响或其他后果”。

### 礼貌表达检查

`Vielen Dank für Ihr Verständnis` 不包含具体事实断言，单独使用符合规则。它在本次输出中出现，但不能据单次输出认定为强制模板；本次扣分与该句无关。

### 测试结果

**PARTIAL**

### 具体偏差

模型已经避开前两轮出现的措施、履约保证、质量保证和“已造成不便”套话，但仍通过 `Dadurch ...` 自动补入一个事实性后果。安全版本应在原因占位符之后直接进入非事实性礼貌结尾，不增加该句。

## 最终结论

- 测试 16 是否完全修复：否，部分修复。关键占位符和四个已知失败模式均已处理，但新增事实性后果的泛化风险仍然存在。
- 是否仍存在事实性商务套话问题：是。具体措辞已变化，不再是道歉套话，而是因果解释式套话；共同问题仍是为了让邮件显得完整而扩写未经提供的后果。
- German Skill MVP 是否建议正式验收：暂不建议。事实保真规则已显著改善，但最终边界测试仍为 PARTIAL。建议在验收前处理这一残留模式，并再次只重跑测试 16。
