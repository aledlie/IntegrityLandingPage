# Integrity Studio Brand Guidelines
## Version 1.0 | December 2024

---

## 1. Brand Overview

### 1.1 Brand Essence

**Mission:** Empower enterprises to build trustworthy AI systems through comprehensive observability and governance tools.

**Vision:** To be the standard for enterprise AI observability, enabling organizations to deploy AI confidently while meeting regulatory requirements.

**Brand Personality:**
- **Professional** - Enterprise-ready, reliable, trustworthy
- **Technical** - Developer-focused, precise, capable
- **Approachable** - Clear communication, helpful, supportive
- **Forward-thinking** - Innovative, proactive, prepared

### 1.2 Brand Promise

We help organizations understand, monitor, and govern their AI systems with tools designed for real-world enterprise needs.

---

## 2. Logo

### 2.1 Primary Logo

The Integrity Studio logo consists of the wordmark "Integrity Studio" with an abstract mark representing data flow and observability.

```
[Logo placeholder - to be designed]

Specifications:
- Primary: Full horizontal lockup
- Secondary: Stacked lockup for square spaces
- Icon: Abstract mark only (for favicons, app icons)
```

### 2.2 Logo Clear Space

Minimum clear space around the logo equals the height of the "I" in "Integrity" (1x unit).

```
    ┌─────────────────────────┐
    │         1x              │
    │    ┌───────────┐        │
    │ 1x │   LOGO    │ 1x     │
    │    └───────────┘        │
    │         1x              │
    └─────────────────────────┘
```

### 2.3 Minimum Size

- **Digital:** 24px height minimum
- **Print:** 0.5 inch / 12mm height minimum

### 2.4 Logo Variations

| Variation | Background | Usage |
|-----------|------------|-------|
| Primary (Light) | Dark backgrounds (gray-900, gray-800) | Primary usage |
| Reversed (Dark) | Light backgrounds | Documentation, print |
| Monochrome | Any | Single-color contexts |
| Icon Only | Any | Favicons, app icons, small spaces |

### 2.5 Logo Misuse

Do NOT:
- Rotate or skew the logo
- Add drop shadows or effects
- Change the logo colors outside approved palette
- Place on busy backgrounds without contrast
- Stretch or distort proportions
- Add outlines or strokes
- Use outdated versions

---

## 3. Color Palette

### 3.1 Primary Colors

```
┌─────────────────────────────────────────────────────────┐
│  BLUE 500 (Primary)                                     │
│  #3B82F6 | RGB: 59, 130, 246 | HSL: 217, 91%, 60%      │
│  Usage: Primary buttons, links, key accents             │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  INDIGO 500 (Secondary)                                 │
│  #6366F1 | RGB: 99, 102, 241 | HSL: 239, 84%, 67%      │
│  Usage: Gradients, secondary accents, hover states      │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  PURPLE 500 (Accent)                                    │
│  #A855F7 | RGB: 168, 85, 247 | HSL: 271, 91%, 65%      │
│  Usage: Gradient endpoints, special highlights          │
└─────────────────────────────────────────────────────────┘
```

### 3.2 Extended Blue Palette

```
Blue 400:  #60A5FA  - Hover states, secondary text links
Blue 500:  #3B82F6  - Primary actions (DEFAULT)
Blue 600:  #2563EB  - Pressed states
Blue 900:  #1E3A8A  - Dark accents, backgrounds
```

### 3.3 Neutral Colors (Dark Theme)

```
Gray 900:  #111827  - Primary background
Gray 800:  #1F2937  - Card backgrounds, elevated surfaces
Gray 700:  #374151  - Borders, dividers
Gray 600:  #4B5563  - Disabled text
Gray 500:  #6B7280  - Placeholder text
Gray 400:  #9CA3AF  - DO NOT USE for body text (fails WCAG)
Gray 300:  #D1D5DB  - Body text, secondary text (4.8:1 contrast)
White:     #FFFFFF  - Headings, primary text (21:1 contrast)
```

### 3.4 Semantic Colors

```
Success:   #22C55E  - Positive states, confirmations
Warning:   #F59E0B  - Caution states, alerts
Error:     #EF4444  - Error states, destructive actions
Info:      #3B82F6  - Informational messages (same as Blue 500)
```

### 3.5 Gradients

**Primary Gradient** (Buttons, CTAs)
```css
background: linear-gradient(135deg, #3B82F6 0%, #4F46E5 100%);
```

**Accent Gradient** (Hero backgrounds, special elements)
```css
background: linear-gradient(135deg, #3B82F6 0%, #6366F1 50%, #9333EA 100%);
```

**Orb Gradient** (Decorative elements)
```css
background: radial-gradient(circle, rgba(59,130,246,0.6) 0%, rgba(59,130,246,0) 70%);
```

### 3.6 Color Accessibility

All text must meet WCAG AA standards:
- **Normal text (16px):** Minimum 4.5:1 contrast ratio
- **Large text (24px+):** Minimum 3:1 contrast ratio
- **UI components:** Minimum 3:1 contrast ratio

| Text Color | Background | Contrast | Status |
|------------|------------|----------|--------|
| White | Gray 900 | 21:1 | PASS |
| Gray 300 | Gray 900 | 4.8:1 | PASS |
| Gray 400 | Gray 900 | 3.2:1 | FAIL - Do not use |
| Blue 400 | Gray 900 | 4.6:1 | PASS |

---

## 4. Typography

### 4.1 Primary Typeface: Inter

Inter is our primary typeface for all digital applications. It provides excellent readability at all sizes and supports a wide range of languages.

```
Font Family: Inter
Source: Google Fonts (https://fonts.google.com/specimen/Inter)
License: Open Font License
```

**Weights Used:**
- Regular (400) - Body text
- Medium (500) - Emphasized text, labels
- SemiBold (600) - Subheadings, buttons
- Bold (700) - Headings

### 4.2 Code Typeface: JetBrains Mono

For code snippets, terminal output, and technical content.

```
Font Family: JetBrains Mono
Source: Google Fonts
License: Open Font License
```

### 4.3 Type Scale

```
Heading XL:   64px / Bold / 1.1 line-height / -0.02 letter-spacing
Heading LG:   48px / Bold / 1.15 line-height / -0.01 letter-spacing
Heading MD:   36px / Bold / 1.2 line-height
Heading SM:   24px / SemiBold / 1.3 line-height
Body LG:      20px / Regular / 1.6 line-height
Body MD:      16px / Regular / 1.5 line-height
Body SM:      14px / Regular / 1.5 line-height
Caption:      12px / Medium / 1.4 line-height
Button:       16px / SemiBold / 1.0 line-height / 0.01 letter-spacing
```

### 4.4 Responsive Typography

| Breakpoint | Heading XL | Heading LG | Heading MD |
|------------|------------|------------|------------|
| Mobile (<768px) | 40px | 32px | 28px |
| Tablet (768-1024px) | 52px | 40px | 32px |
| Desktop (>1024px) | 64px | 48px | 36px |

### 4.5 Typography Colors

- **Headings:** White (#FFFFFF)
- **Body text:** Gray 300 (#D1D5DB)
- **Secondary text:** Gray 300 (#D1D5DB)
- **Captions:** Gray 300 (#D1D5DB) - NOT Gray 400
- **Links:** Blue 400 (#60A5FA)
- **Code:** Blue 400 (#60A5FA) on Gray 800

---

## 5. Spacing System

### 5.1 Base Unit

Our spacing system is based on a 4px grid. All spacing values are multiples of 4.

```
XS:    4px   (0.25rem)
SM:    8px   (0.5rem)
MD:    16px  (1rem)
LG:    24px  (1.5rem)
XL:    32px  (2rem)
XXL:   48px  (3rem)
XXXL:  64px  (4rem)
Section: 80px (5rem)
```

### 5.2 Container Widths

```
Max Content Width: 1280px
Mobile Padding: 16px
Tablet Padding: 24px
Desktop Padding: 32px
```

### 5.3 Section Spacing

```
Desktop: 80px vertical padding
Mobile: 48px vertical padding
Between sections: 0px (sections handle their own padding)
```

---

## 6. Components

### 6.1 Buttons

**Primary Button (Gradient)**
```
Background: Primary gradient
Border Radius: 8px
Padding: 16px 32px
Text: White, 16px SemiBold
Shadow: 0 4px 16px rgba(59, 130, 246, 0.3)
Hover: Lift 2px, increase shadow
Disabled: Gray gradient, no shadow
```

**Secondary Button (Outline)**
```
Background: Transparent
Border: 1px solid Gray 700
Border Radius: 8px
Padding: 16px 32px
Text: White, 16px SemiBold
Hover: Border Blue 500, subtle glow
```

**Text Button**
```
Background: None
Text: Blue 400, 16px Medium
Hover: Underline
```

### 6.2 Cards

**Glass Card (Primary)**
```
Background: Gray 900 at 95% opacity (web) / 80% opacity (native)
Border: 1px solid Gray 700 at 50% opacity
Border Radius: 16px
Shadow: 0 8px 24px rgba(17, 24, 39, 0.3)
Hover: Lift 4px, border Blue 500 at 50%
```

**Solid Card (Secondary)**
```
Background: Gray 800
Border: 1px solid Gray 700
Border Radius: 12px
Shadow: 0 4px 12px rgba(17, 24, 39, 0.2)
```

### 6.3 Form Elements

**Text Input**
```
Background: Gray 800
Border: 1px solid Gray 700
Border Radius: 8px
Padding: 16px
Text: White, 16px Regular
Placeholder: Gray 500
Focus: Border Blue 500, 2px width
Error: Border Error Red
```

**Checkbox/Radio**
```
Size: 20px
Border: 2px solid Gray 600
Border Radius: 4px (checkbox) / 50% (radio)
Checked: Blue 500 fill, white checkmark
Focus: Blue 400 ring
```

### 6.4 Icons

**Icon Style:** Lucide Icons (outline style)
**Default Size:** 24px
**Colors:**
- Default: Gray 300
- Interactive: Blue 400
- In buttons: White

**Icon Container (Feature cards)**
```
Background: Gradient (Blue 500 to Indigo 600)
Border Radius: 12px
Size: 48px
Icon: White, 24px
```

---

## 7. Imagery

### 7.1 Photography Style

We primarily use abstract data visualizations and product screenshots rather than stock photography.

**When photography is needed:**
- Authentic, candid moments
- Diverse representation
- Modern tech environments
- Avoid: Cliche stock poses, handshakes, pointing at screens

### 7.2 Illustrations

**Style Guidelines:**
- Abstract, geometric forms
- Data flow and network visualizations
- Blue/indigo/purple color palette
- Clean, minimal compositions
- Subtle gradients and glows

### 7.3 Screenshots & Mockups

**Dashboard Screenshots:**
- Use dark theme matching brand colors
- Blur or anonymize sensitive data
- Show realistic, meaningful data
- Consistent browser/device frames

### 7.4 Decorative Elements

**Animated Orbs:**
- Subtle, slow-moving (10-15s animation cycle)
- 15-20% opacity
- Blue and indigo colors
- Limited to 2-3 per page section
- Use static gradient fallback on mobile

**Noise Texture:**
- 5% opacity overlay
- Adds depth to gradient backgrounds
- Subtle grain effect

---

## 8. Voice & Tone

### 8.1 Brand Voice

**Professional but Approachable**
- Write clearly and directly
- Avoid jargon when possible; explain when necessary
- Be helpful, not condescending
- Show expertise without being intimidating

**Technical but Accessible**
- Lead with benefits, follow with technical details
- Use code examples where helpful
- Provide context for technical terms
- Write for developers AND their managers

**Confident but Not Overreaching**
- Make claims we can substantiate
- NEVER claim certifications we don't have
- Use qualified language for compliance features
- Be honest about limitations

### 8.2 Writing Guidelines

**Do:**
- Use active voice
- Keep sentences concise
- Lead with the most important information
- Use specific numbers when available
- Include source citations for statistics

**Don't:**
- Use buzzwords without meaning
- Make unsubstantiated claims
- Use fear-based urgency excessively
- Promise guaranteed compliance outcomes
- Use "we" when referring to the user's actions

### 8.3 Compliance Language

**Approved Phrases:**
- "Tools to support EU AI Act compliance efforts"
- "Designed to help prepare for regulatory requirements"
- "Alignment with EU AI Act framework"
- "Compliance preparation tools"

**NOT Approved (Legal Risk):**
- "EU AI Act Compliant" (unless certified)
- "Guarantees compliance"
- "Fully compliant"
- "Certified" (unless we have the certification)

### 8.4 Example Copy

**Hero Headline:**
```
Enterprise-Grade AI Observability

Monitor LLM performance, support EU AI Act compliance
preparation, and gain visibility into your AI systems.
```

**Feature Description:**
```
Risk Assessment Tools

Templates to help assess AI system risk categories aligned
with EU AI Act framework. Results require validation with
your legal team.
```

**CTA Button:**
```
Start Free Trial (Good)
Get Started Free (Good)
Try It Now (Acceptable)
Get Compliant Now (NOT approved - overpromises)
```

---

## 9. Social Media & Marketing

### 9.1 Social Media Profiles

**Profile Image:** Logo icon mark on Gray 900 background
**Cover Image:** Brand gradient with tagline

### 9.2 Open Graph Image

```
Dimensions: 1200 x 630 px
Background: Gray 900 with subtle gradient
Content: Logo + Tagline + Key visual
Text: Large enough to read in thumbnails
```

### 9.3 Social Post Templates

**Announcement Posts:**
- Gray 900 background
- Headline in White
- Blue accent for key points
- Logo in corner

**Educational Posts:**
- Clean layout with ample white space
- Code snippets when relevant
- Numbered lists for clarity

### 9.4 Email Marketing

**Header:** Logo on Gray 900
**Body Background:** Gray 800
**Text:** White headings, Gray 300 body
**CTA Buttons:** Primary gradient
**Footer:** Gray 900 with Gray 500 text

---

## 10. File Naming Conventions

### 10.1 Logo Files

```
integrity-studio-logo-primary.svg
integrity-studio-logo-reversed.svg
integrity-studio-logo-mono.svg
integrity-studio-icon.svg
integrity-studio-icon-192.png
integrity-studio-icon-512.png
integrity-studio-favicon.ico
```

### 10.2 Marketing Assets

```
og-image-homepage.png
og-image-blog-[slug].png
social-linkedin-banner.png
social-twitter-header.png
ad-banner-[size]-[variant].png
```

### 10.3 Product Screenshots

```
screenshot-dashboard-overview.png
screenshot-trace-viewer.png
screenshot-compliance-report.png
mockup-[feature]-[device].png
```

---

## 11. Asset Checklist

### Required for Launch

- [ ] Logo (SVG, PNG in multiple sizes)
- [ ] Logo variations (light, dark, icon)
- [ ] Favicon (ICO, PNG 192, PNG 512)
- [ ] OG Image (1200x630)
- [ ] Twitter Card Image
- [ ] Dashboard mockup for hero
- [ ] 6 feature icons
- [ ] 12 integration partner logos

### Post-Launch

- [ ] LinkedIn banner
- [ ] Email header template
- [ ] Ad banner set (6 sizes)
- [ ] Blog featured image template
- [ ] Infographic template
- [ ] Presentation template
- [ ] Brand guidelines PDF

---

## 12. Contact

For brand-related questions or asset requests:

**Brand Manager:** [To be assigned]
**Email:** brand@integritystudio.ai
**Assets:** [Link to brand asset repository]

---

*Last Updated: December 2024*
*Version: 1.0*
*Next Review: March 2025*
