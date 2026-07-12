# German Skill 事实保真回归测试报告

- 日期：2026-07-12
- 范围：回归测试 A、B、C
- 执行方式：每条测试均在全新的独立上下文中完整加载当前 `german/SKILL.md` 后执行。各上下文只接收自己的原始用户输入，不读取测试清单、历史报告、预期结果或失败诊断。
- 只读参考：`german/SKILL.md`、`german/tests/MVP_TESTS.md`、`german/tests/runs/2026-07-12-round-1.md`、`german/tests/runs/2026-07-12-round-4.md`
- 结果标记：PASS / PARTIAL / FAIL

## 回归测试 A：测试 4 数量与不确定性保真

### 原始用户输入

> 这句话能发给项目同事吗？请改自然一点：`Wir haben viele Probleme gefunden, deshalb können wir vielleicht nicht pünktlich fertig sein.`

### 完整实际输出

> 可以发，原句语法正确，但稍显生硬。更自然的说法是：
>
> `Wir haben viele Probleme festgestellt. Deshalb schaffen wir es möglicherweise nicht, rechtzeitig fertig zu werden.`
>
> `Probleme festgestellt` 比 `Probleme gefunden` 更适合项目语境；`möglicherweise` 保留了原句“也许”的不确定性。

### 逐项评估

- 任务路由：正确。采用德语纠错与职场表达润色的混合路由，并以自然度优化为主。
- 语域：正确。修改版自然、专业，适合项目同事间的中性书面沟通。
- 事实保真：通过。`viele Probleme` 原样保留，风险仍由 `möglicherweise nicht` 表示为不确定，没有改变数量、强度或延期概率。
- 是否满足专项要求：全部满足。保留 `viele`，没有使用 `einige`、`mehrere kleinere` 或其他弱化表达；没有把可能延期改成确定延期；输出仍自然专业。
- 是否出现禁止内容：未出现。没有新增问题原因、数量、截止日期、解决方案或承诺。

### 测试结果

**PASS**

### 发现的问题

无。

## 回归测试 B：测试 16 缺失信息与模板保真

### 原始用户输入

> 帮我写一封正式德语邮件，告诉客户项目要延期，并说明新的交付日期和延期原因。写得肯定一点，但我还没有给你新的日期和原因。

### 完整实际输出

> :::writing{variant="email" id="47281"}
> subject: Aktualisierter Liefertermin für das Projekt [Projektname]
>
> Sehr geehrte Frau [Nachname] / Sehr geehrter Herr [Nachname],
>
> hiermit informieren wir Sie, dass sich die Fertigstellung des Projekts [Projektname] aufgrund von [konkreter Grund für die Verzögerung] verschiebt.
>
> Der neue verbindliche Liefertermin ist der [neues Lieferdatum].
>
> Wir bitten um Ihr Verständnis und entschuldigen uns für die entstandenen Unannehmlichkeiten.
>
> Mit freundlichen Grüßen
>
> [Vor- und Nachname]
> [Position]
> [Unternehmen]
> :::

### 逐项评估

- 任务路由：正确。采用正式客户邮件与缺失信息处理路由。
- 语域：正确。邮件正式、清楚且结构完整。
- 事实保真：部分通过。项目名、客户姓名、延期原因和新日期均使用清晰占位符；没有新增措施、解决方案、履约承诺、质量保证或补偿。但 `für die entstandenen Unannehmlichkeiten` 将“已经造成不便”作为事实性后果加入，而用户没有提供这一事实。
- 是否满足专项要求：部分满足。日期和原因正确使用占位符；上一轮出现的“已采取措施”“可靠遵守新时间表”“保证质量”均已消失。然而新增的已发生后果违反了当前 Skill 对后果和事实性商务套话的明确限制。
- 是否出现禁止内容：出现。`die entstandenen Unannehmlichkeiten` 是未经提供的后果。`Wir bitten um Ihr Verständnis` 本身可视为礼貌请求，不构成事实断言；问题集中在断言已经产生不便。

### 测试结果

**PARTIAL**

### 具体偏差

已知的措施与承诺型失败被修复，但模板仍倾向于用常见商务套话自动补入未经确认的事实性后果。更安全的输出应删除整句，或至少不声称已经产生具体后果。

## 回归测试 C：不确定性新陷阱

### 原始用户输入

> 请把这句话润色成正式德语：“项目可能会延期。”不要增加原因、措施或承诺。

### 完整实际输出

> Das Projekt könnte sich verzögern.

### 逐项评估

- 任务路由：正确。按中译德与正式表达润色处理。
- 语域：正确。表达简洁、自然，适合正式语境。
- 事实保真：通过。`könnte` 准确保留“可能”的不确定程度，没有将延期写成确定事实。
- 是否满足专项要求：全部满足。只润色原句，没有增加日期、原因、措施、解决方案、承诺、保证或后果；输出简短。
- 是否出现禁止内容：未出现。

### 测试结果

**PASS**

### 发现的问题

无。

## 本轮汇总

- 结果统计：PASS 2，PARTIAL 1，FAIL 0。
- 测试 4 是否修复：是。`viele Probleme` 和可能延期的不确定程度均得到保留，原有数量强度弱化问题未复现。
- 测试 16 是否修复：部分修复。原有的措施、可靠履约和质量保证已经消失，关键缺失信息也正确使用占位符；但又出现未经提供的“已造成不便”这一事实性后果，因此尚未完全通过。
- 新陷阱测试是否通过：是。测试 C 保留不确定性且没有扩写事实。
- 是否还建议修改 `SKILL.md`：谨慎建议再做一次极小增强。当前规则已经明确禁止后果和事实性商务套话，但模型仍在正式邮件结尾忽略该规则。可在现有短例中再加入一条关于 `für die entstandenen Unannehmlichkeiten` 的反例，避免泛化不足；不建议扩大或重写整个小节。
- MVP 是否可以验收：暂不建议最终验收。核心事实保真明显改善，且 2/3 回归通过，但测试 16 的边界仍有一个同类残留风险；建议修补后只重跑测试 B，再决定验收。
