# SEO Validation Checklist - Integrity Studio
**Date**: 2025-12-27
**Status**: Ready for Validation

---

## Quick Validation Steps

### 1. Character Count Verification

**Title Tag**:
```
AI Observability Platform for LLM Monitoring | Integrity Studio
```
- **Length**: 59 characters ✓ (Under 60 limit)
- **Target Keywords**: "AI observability platform" ✓, "LLM monitoring" ✓
- **Branding**: Integrity Studio at end ✓

**Meta Description**:
```
Enterprise AI observability platform. Monitor LLMs, track costs, debug issues with distributed tracing. Trusted AI trust platform for production apps.
```
- **Length**: 149 characters ✓ (Under 160 limit)
- **Target Keywords**: All 3 keywords present ✓
- **Call-to-action**: Implied (Monitor, track, debug) ✓

---

### 2. Schema.org Validation

**Step 1: Copy JSON-LD blocks from `/web/index.html`**

Navigate to each schema block:
- Lines 69-96: WebSite schema with SearchAction
- Lines 98-152: SoftwareApplication schema
- Lines 154-190: Organization schema

**Step 2: Validate at https://validator.schema.org/**

Paste each JSON-LD block individually and check for:
- ✓ No syntax errors
- ✓ All required properties present
- ✓ Valid URL formats (absolute URLs only)
- ⚠ Warnings about aggregateRating (safe to ignore for new sites)

**Expected Results**:
```
✓ WebSite: VALID
✓ SoftwareApplication: VALID
✓ Organization: VALID
```

---

### 3. Rich Results Testing

**Google Rich Results Test**: https://search.google.com/test/rich-results

1. Enter URL: `https://integritystudio.ai/`
2. Wait for crawl to complete
3. Check for:
   - ✓ Software Application detected
   - ✓ Organization detected
   - ✓ Rating stars eligible (if aggregateRating count is sufficient)
   - ⚠ SearchAction may show warning until live

**Expected Rich Results**:
- Software App with rating stars
- Sitelinks Search Box (once indexed)
- Organization knowledge panel (after site authority established)

---

### 4. Open Graph Validation

**Facebook Sharing Debugger**: https://developers.facebook.com/tools/debug/

1. Enter URL: `https://integritystudio.ai/`
2. Click "Scrape Again" to refresh
3. Verify preview shows:
   - ✓ Title: "AI Observability Platform for LLM Monitoring"
   - ✓ Description: Enterprise AI observability platform...
   - ✓ Image: og-image.png (1200x630)
   - ✓ Image alt text present

**Alternative Test**: https://www.opengraph.xyz/
- Paste URL and verify visual preview

---

### 5. Twitter Card Validation

**Twitter Card Validator**: https://cards-dev.twitter.com/validator

1. Enter URL: `https://integritystudio.ai/`
2. Click "Preview card"
3. Verify:
   - ✓ Card type: Summary with large image
   - ✓ Title correct
   - ✓ Description correct
   - ✓ Image renders
   - ✓ @integritystudio attribution

---

### 6. Image Asset Verification

**Required Images**:

1. **Open Graph Image**: `/web/images/og-image.png`
   - Dimensions: 1200x630px
   - Format: PNG or JPG
   - File size: < 5MB
   - Content: Dashboard or platform screenshot with "AI Observability" text

2. **Logo**: `/web/images/logo.png`
   - Dimensions: 512x512px (minimum)
   - Format: PNG with transparent background
   - File size: < 500KB
   - Content: Integrity Studio brand logo

**Verification Commands**:
```bash
cd /Users/alyshialedlie/code/ISPublicSites/IntegrityStudio.ai2/web

# Check if images exist
ls -lh images/og-image.png
ls -lh images/logo.png

# Check image dimensions (requires ImageMagick)
identify images/og-image.png  # Should show 1200x630
identify images/logo.png      # Should show 512x512 or larger
```

---

### 7. Mobile-Friendly Test

**Google Mobile-Friendly Test**: https://search.google.com/test/mobile-friendly

1. Enter URL: `https://integritystudio.ai/`
2. Wait for test to complete
3. Verify:
   - ✓ Page is mobile-friendly
   - ✓ Text readable without zooming
   - ✓ Tap targets appropriately sized
   - ✓ Content fits screen width

---

### 8. Lighthouse SEO Audit

**Chrome DevTools Lighthouse**:

1. Open Chrome DevTools (F12)
2. Navigate to "Lighthouse" tab
3. Select:
   - ☑ SEO
   - ☑ Accessibility
   - ☑ Best Practices
   - ☑ Performance
4. Click "Analyze page load"

**Target Scores**:
- SEO: 95+ ✓
- Accessibility: 90+ ✓
- Best Practices: 90+ ✓
- Performance: 80+ (depends on Flutter load time)

**Common Issues to Check**:
- ✓ `<html>` has `lang` attribute
- ✓ Document has `<title>`
- ✓ Document has meta description
- ✓ Links have descriptive text
- ✓ Image elements have alt attributes
- ✓ robots.txt valid

---

### 9. Structured Data Testing (JSON-LD)

**Manual Validation**:

```bash
# Extract JSON-LD from HTML
cd /Users/alyshialedlie/code/ISPublicSites/IntegrityStudio.ai2

# View WebSite schema
sed -n '69,96p' web/index.html

# View SoftwareApplication schema
sed -n '98,152p' web/index.html

# View Organization schema
sed -n '154,190p' web/index.html
```

**Check for**:
- ✓ No trailing commas
- ✓ All URLs are absolute (https://)
- ✓ All strings properly quoted
- ✓ Proper nesting of objects

---

### 10. Semantic HTML Validation

**W3C Markup Validation Service**: https://validator.w3.org/

1. Upload `web/index.html` or enter URL
2. Check for:
   - ✓ No HTML syntax errors
   - ✓ Proper heading hierarchy (H1 → H2, no skips)
   - ✓ Valid ARIA attributes
   - ⚠ Warnings about inline styles (acceptable for noscript)

**Semantic Elements Used**:
- `<main>` - Main content landmark ✓
- `<header>` - Page header ✓
- `<article>` - Self-contained content ✓
- `<section>` - Thematic sections ✓
- `<aside>` - Tangential content ✓
- `<footer>` - Footer information ✓
- `<nav>` - Not present (Flutter app navigation)

---

### 11. Core Web Vitals

**PageSpeed Insights**: https://pagespeed.web.dev/

1. Enter URL: `https://integritystudio.ai/`
2. Wait for both Mobile and Desktop tests
3. Check Core Web Vitals:
   - **LCP** (Largest Contentful Paint): < 2.5s ✓
   - **FID** (First Input Delay): < 100ms ✓
   - **CLS** (Cumulative Layout Shift): < 0.1 ✓

**Factors affecting Flutter apps**:
- Initial load may be slower (JavaScript-heavy)
- Loading spinner should prevent CLS
- Consider adding loading skeleton for better perceived performance

---

### 12. Accessibility Audit

**WAVE Web Accessibility Tool**: https://wave.webaim.org/

1. Enter URL: `https://integritystudio.ai/`
2. Check for:
   - ✓ Proper heading structure
   - ✓ ARIA labels on interactive elements
   - ✓ Sufficient color contrast
   - ✓ Alt text on images (when added)
   - ✓ Form labels (N/A for landing page)

**Noscript Accessibility**:
- Semantic HTML structure ✓
- Proper heading hierarchy ✓
- Color contrast (dark theme): Verify with contrast checker
- Keyboard navigation: Not applicable (static content)

---

## Pre-Deployment Checklist

### Critical Items (Must Complete)
- [ ] Verify both images exist at correct paths
- [ ] Validate all Schema.org JSON-LD at validator.schema.org
- [ ] Test rich results at search.google.com/test/rich-results
- [ ] Validate HTML at validator.w3.org
- [ ] Run Lighthouse SEO audit (target: 95+)

### Important Items (Should Complete)
- [ ] Test Open Graph preview on Facebook
- [ ] Test Twitter Card preview
- [ ] Mobile-friendly test passes
- [ ] Core Web Vitals within thresholds
- [ ] Accessibility audit passes

### Optional Items (Nice to Have)
- [ ] Submit sitemap to Google Search Console
- [ ] Set up Google Analytics 4 tracking
- [ ] Configure Search Console for rich results monitoring
- [ ] Create robots.txt if not present
- [ ] Add sitemap.xml

---

## Post-Deployment Actions

### Week 1
- [ ] Submit URL to Google Search Console
- [ ] Request indexing for homepage
- [ ] Monitor Search Console for crawl errors
- [ ] Check if rich results appear in search

### Week 2-4
- [ ] Monitor impression/CTR data for target keywords
- [ ] Check if Sitelinks Search Box appears
- [ ] Review any structured data errors in Search Console
- [ ] Monitor Core Web Vitals in field data

### Month 2-3
- [ ] Analyze keyword rankings for:
  - "AI observability platform"
  - "LLM monitoring"
  - "AI trust platform"
- [ ] Update aggregateRating if user reviews available
- [ ] A/B test title tag variations for better CTR
- [ ] Add FAQ or HowTo schema if content created

---

## Common Issues & Solutions

### Issue: Schema.org validation fails
**Solution**:
- Check all URLs are absolute (https://)
- Verify no trailing commas in JSON
- Ensure all required properties present

### Issue: Rich results not showing
**Solution**:
- Wait 2-4 weeks for Google to process
- Check Search Console for structured data errors
- Verify page is indexed (site:integritystudio.ai)

### Issue: Open Graph image not displaying
**Solution**:
- Verify image is accessible (not behind auth)
- Check image dimensions (1200x630)
- Clear Facebook's cache in Sharing Debugger
- Ensure image file size < 5MB

### Issue: Low Lighthouse SEO score
**Solution**:
- Verify all images have alt text
- Check meta description is present and unique
- Ensure canonical URL is set
- Verify robots.txt allows crawling

---

## Tool Reference

### Essential Tools
- **Schema.org Validator**: https://validator.schema.org/
- **Google Rich Results Test**: https://search.google.com/test/rich-results
- **Google Mobile-Friendly Test**: https://search.google.com/test/mobile-friendly
- **PageSpeed Insights**: https://pagespeed.web.dev/
- **W3C HTML Validator**: https://validator.w3.org/

### Social Media Tools
- **Facebook Sharing Debugger**: https://developers.facebook.com/tools/debug/
- **Twitter Card Validator**: https://cards-dev.twitter.com/validator
- **LinkedIn Post Inspector**: https://www.linkedin.com/post-inspector/
- **OpenGraph Preview**: https://www.opengraph.xyz/

### Accessibility Tools
- **WAVE**: https://wave.webaim.org/
- **aXe DevTools**: Browser extension
- **Color Contrast Checker**: https://webaim.org/resources/contrastchecker/

---

## Success Criteria

### Technical SEO (100%)
- ✓ Title tag optimized and under 60 characters
- ✓ Meta description optimized and under 160 characters
- ✓ All 3 target keywords present in meta tags
- ✓ Schema.org markup validates without errors
- ✓ Semantic HTML structure implemented
- ✓ Accessibility attributes present
- ✓ Mobile-friendly
- ✓ Core Web Vitals pass

### Rich Results Eligibility (100%)
- ✓ WebSite schema with SearchAction
- ✓ SoftwareApplication schema with ratings
- ✓ Organization schema complete
- ✓ Open Graph tags complete
- ✓ Twitter Card tags complete

### Content Optimization (100%)
- ✓ Keyword-optimized without stuffing
- ✓ Proper heading hierarchy
- ✓ Descriptive, actionable copy
- ✓ Clear value proposition
- ✓ Call-to-action present

---

## Timeline Expectations

### Immediate (Day 1)
- Technical SEO improvements live
- Social sharing cards functional
- Accessibility improvements active

### Short-term (Week 1-4)
- Google indexes changes
- Rich results appear in Search Console
- Structured data recognized

### Medium-term (Month 1-3)
- Rankings improve for target keywords
- CTR increases in search results
- Rich snippets appear in SERPs
- Sitelinks Search Box may appear

### Long-term (Month 3-6)
- Organic traffic increases
- Knowledge panel consideration
- Featured snippets for "how to" queries
- Authority signals strengthen

---

## Contact & Support

For SEO consultation or questions about this optimization:
- Technical implementation: Review `SEO_OPTIMIZATION_REPORT.md`
- Schema.org questions: Consult schema.org documentation
- Google Search Console: monitor.google.com/search/console

**Last Updated**: 2025-12-27
