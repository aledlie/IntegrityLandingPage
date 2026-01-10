# LLM Cost Optimization Page - MVP Plan

**Date:** December 27, 2025
**Target URL:** `https://integritystudio.ai/blog/llm-cost-optimization-guide`
**Build Time:** 4-6 hours
**Approach:** Ship simple, iterate based on data

---

## 1. What We're Building

A static HTML page with:
1. Pricing comparison table (10 models)
2. Simple cost calculator (pure JS)
3. 5 optimization tips
4. 5 FAQs
5. CTA to Integrity Studio services

**What we're NOT building (v1):**
- Email capture / lead gating
- Shareable URLs with state
- OG image generation
- PDF exports
- Exit intent popups
- Embed widgets
- Automated price monitoring

---

## 2. Pricing Data (Verified December 2025)

### Data Structure

```javascript
const LLM_PRICING = {
  lastVerified: '2025-12-27',
  models: [
    // OpenAI
    { id: 'gpt-4o', provider: 'OpenAI', name: 'GPT-4o', input: 2.50, output: 10.00 },
    { id: 'gpt-4o-mini', provider: 'OpenAI', name: 'GPT-4o mini', input: 0.15, output: 0.60 },
    { id: 'o1', provider: 'OpenAI', name: 'o1 (reasoning)', input: 15.00, output: 60.00 },
    { id: 'o1-mini', provider: 'OpenAI', name: 'o1-mini', input: 3.00, output: 12.00 },
    // Anthropic
    { id: 'claude-opus', provider: 'Anthropic', name: 'Claude Opus 4.5', input: 5.00, output: 25.00 },
    { id: 'claude-sonnet', provider: 'Anthropic', name: 'Claude Sonnet 4.5', input: 3.00, output: 15.00 },
    { id: 'claude-haiku', provider: 'Anthropic', name: 'Claude Haiku 4.5', input: 1.00, output: 5.00 },
    // Google
    { id: 'gemini-pro', provider: 'Google', name: 'Gemini 2.5 Pro', input: 1.25, output: 10.00 },
    { id: 'gemini-flash', provider: 'Google', name: 'Gemini 2.5 Flash', input: 0.30, output: 2.50 },
    // DeepSeek
    { id: 'deepseek-v3', provider: 'DeepSeek', name: 'DeepSeek V3', input: 0.27, output: 1.10 },
    { id: 'deepseek-r1', provider: 'DeepSeek', name: 'DeepSeek R1', input: 0.55, output: 2.19 },
  ]
};
```

---

## 3. Page Structure

```html
1. TITLE + INTRO (50 words)
   "LLM Cost Optimization Guide (2025)"
   "Compare API pricing and calculate your monthly costs."

2. PRICING TABLE
   | Provider | Model | Input $/1M | Output $/1M |
   (11 models, sorted by input cost)

3. CALCULATOR
   - Model dropdown (all 11 models)
   - Input tokens per request (number input, default 1000)
   - Output tokens per request (number input, default 500)
   - Requests per day (number input, default 100)
   → Output: Monthly cost, cost per request
   → Comparison: "X% cheaper than GPT-4o"

4. QUICK TIPS (5 bullets, ~200 words)
   - Use smaller models for simple tasks
   - Enable prompt caching (90% savings on cache hits)
   - Batch non-urgent requests (50% off with OpenAI)
   - Consider DeepSeek for cost-sensitive workloads
   - Monitor spending with budget alerts

5. FAQ (5 questions, ~300 words total)
   - How much does GPT-4 cost per token?
   - What's the cheapest LLM API in 2025?
   - How can I reduce OpenAI costs?
   - Is Claude cheaper than GPT-4?
   - What is prompt caching?

6. CTA
   "Monitor your LLM costs with Integrity Studio"
   [Link to services page]

7. FOOTER
   "Last verified: December 27, 2025"
   Links to official pricing pages
```

---

## 4. Calculator Specification

### Inputs
```javascript
{
  modelId: string,        // from dropdown
  inputTokens: number,    // 1-100000, default 1000
  outputTokens: number,   // 1-50000, default 500
  requestsPerDay: number  // 1-100000, default 100
}
```

### Calculation
```javascript
function calculateCost(modelId, inputTokens, outputTokens, requestsPerDay) {
  const model = LLM_PRICING.models.find(m => m.id === modelId);
  const inputCost = (inputTokens / 1_000_000) * model.input;
  const outputCost = (outputTokens / 1_000_000) * model.output;
  const costPerRequest = inputCost + outputCost;
  const dailyCost = costPerRequest * requestsPerDay;
  const monthlyCost = dailyCost * 30;

  return {
    costPerRequest: costPerRequest.toFixed(6),
    dailyCost: dailyCost.toFixed(2),
    monthlyCost: monthlyCost.toFixed(2)
  };
}
```

### Output Display
```
Monthly Cost: $XXX.XX
Cost per Request: $X.XXXXXX
Daily Cost: $XX.XX

Comparison:
"This is X% cheaper than GPT-4o for the same workload"
```

---

## 5. Schema.org (FAQPage only)

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "How much does GPT-4 cost per token?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "GPT-4o costs $2.50 per million input tokens and $10.00 per million output tokens. GPT-4o mini is significantly cheaper at $0.15/$0.60 per million tokens."
      }
    },
    {
      "@type": "Question",
      "name": "What is the cheapest LLM API in 2025?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "DeepSeek V3 is currently the cheapest major LLM API at $0.27 per million input tokens, making it 10x cheaper than GPT-4o for input-heavy workloads."
      }
    }
    // ... 3 more questions
  ]
}
```

---

## 6. Meta Tags

```html
<title>LLM Cost Calculator & Optimization Guide (2025) | Integrity Studio</title>
<meta name="description" content="Compare LLM API pricing for GPT-4, Claude, Gemini, and DeepSeek. Free calculator shows monthly costs. Learn techniques to reduce AI spending by 40-80%.">
<link rel="canonical" href="https://integritystudio.ai/blog/llm-cost-optimization-guide">

<!-- Open Graph -->
<meta property="og:title" content="LLM Cost Calculator & Optimization Guide (2025)">
<meta property="og:description" content="Compare pricing and calculate costs for GPT-4, Claude, Gemini, DeepSeek">
<meta property="og:type" content="article">
<meta property="og:url" content="https://integritystudio.ai/blog/llm-cost-optimization-guide">
```

---

## 7. Implementation Tasks

### Task 1: Create HTML structure (1 hour)
- Create `web/blog/llm-cost-optimization-guide.html`
- Add meta tags and FAQPage schema
- Structure sections with semantic HTML

### Task 2: Write content (1.5 hours)
- Pricing table (static HTML)
- 5 optimization tips
- 5 FAQ answers
- Intro and CTA

### Task 3: Build calculator (1.5 hours)
- Model dropdown populated from data
- Three number inputs with labels
- Calculate button / live update
- Results display with comparison

### Task 4: Style and test (1 hour)
- Match existing blog styling
- Mobile responsive
- Test calculations manually
- Verify against official pricing

### Task 5: Deploy (30 min)
- Add to blog navigation
- Build and deploy
- Verify live page

**Total: ~5.5 hours**

---

## 8. Success Criteria (Simple)

**Week 1:**
- [ ] Page loads without errors
- [ ] Calculator produces correct results
- [ ] Indexed by Google

**Month 1:**
- [ ] Appears in Search Console
- [ ] Any organic impressions

**Month 3:**
- [ ] 100+ organic visits
- [ ] Top 50 for any target keyword

---

## 9. Future Iterations (Only if data justifies)

**If page gets 500+ monthly visits:**
- Add caching/batching toggles
- Add model comparison table
- Consider email capture

**If calculator usage is high:**
- Add more models
- Add provider filtering tabs
- Consider shareable URLs

**If content ranks well:**
- Expand optimization techniques section
- Add case studies
- Write follow-up articles

---

## 10. Files to Create

```
web/blog/llm-cost-optimization-guide.html   # Main page (new)
```

No other files needed. Pricing data embedded in HTML.

---

*This MVP replaces the 580-line plan. Ship it, measure it, iterate.*
