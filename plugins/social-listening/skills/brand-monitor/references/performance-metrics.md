# Performance Metrics Guide

## Core Metrics by Platform

### X (Twitter)

| Metric | What It Measures | Good Benchmark | Great Benchmark |
|--------|-----------------|----------------|-----------------|
| Impressions | How many people saw the post | >1000 | >10,000 |
| Engagement rate | (Engagements / Impressions) × 100 | >1% | >3% |
| Likes | Passive approval/agreement | Varies by audience size | — |
| Reposts | Active sharing/endorsement | >5% of likes | >15% of likes |
| Replies | Conversation generation | >2% of impressions | >5% of impressions |
| Bookmarks | Save-for-later value | >1% of likes | >5% of likes |
| Profile clicks | Curiosity about author | >0.5% of impressions | >2% of impressions |
| Link clicks | Action taken | >0.5% of impressions | >2% of impressions |

**X-specific insights:**
- High bookmarks + low likes = valuable but not share-worthy (make it more shareable)
- High replies + low likes = controversial or question-based (lean into discussion)
- High reposts = highly shareable (study what made it viral)
- High impressions + low engagement = reach without resonance (improve hook/content)

### Reddit

| Metric | What It Measures | Good Benchmark | Great Benchmark |
|--------|-----------------|----------------|-----------------|
| Upvotes | Community approval | >50 | >500 |
| Upvote ratio | Consensus level | >85% | >95% |
| Comments | Discussion depth | >10 | >100 |
| Awards | Exceptional value | Any | Multiple |
| Cross-posts | Content spread | Any | >3 |

**Reddit-specific insights:**
- Upvote ratio is the truest sentiment signal on any platform
- Comment quality matters more than quantity
- Controversial (50/50 upvote ratio) = polarizing topic
- Top comment often shapes the narrative more than the post itself

### YouTube

| Metric | What It Measures | Good Benchmark | Great Benchmark |
|--------|-----------------|----------------|-----------------|
| Views | Reach | >1000 | >10,000 |
| Watch time | Content quality | >40% avg retention | >60% avg retention |
| Likes | Approval | >4% of views | >8% of views |
| Comments | Engagement depth | >1% of views | >3% of views |
| Subscribers gained | Audience growth | >2% of views | >5% of views |
| Click-through rate | Thumbnail/title effectiveness | >4% | >10% |

**YouTube-specific insights:**
- Watch time is the most important metric (drives algorithm)
- CTR indicates title/thumbnail effectiveness
- Drop-off points reveal content structure issues
- Subscriber conversion shows long-term value perception

### LinkedIn

| Metric | What It Measures | Good Benchmark | Great Benchmark |
|--------|-----------------|----------------|-----------------|
| Impressions | Reach | >5000 | >50,000 |
| Engagement rate | (Engagements / Impressions) × 100 | >2% | >5% |
| Reactions | Type of response (like, celebrate, insightful, etc.) | >50 | >500 |
| Comments | Discussion quality | >10 | >50 |
| Reposts | Amplification | >5 | >50 |
| Profile views | Professional interest | >20/post | >100/post |
| Followers gained | Audience growth | >5/post | >50/post |

**LinkedIn-specific insights:**
- "Insightful" reactions indicate thought leadership value
- Comment quality is the highest-value metric on LinkedIn
- Dwell time (time spent reading) affects algorithm but isn't visible
- Document/carousel posts consistently outperform text-only
- First-hour engagement heavily influences total reach

### Podcasts

| Metric | What It Measures | Good Benchmark | Great Benchmark |
|--------|-----------------|----------------|-----------------|
| Mentions | Times mentioned in episodes | Any | >3 in 30 days |
| Context | How mentioned (positive, neutral, negative) | Neutral+ | Positive |
| Reach | Estimated podcast audience | >1000 listeners | >10,000 listeners |
| Recurring | Mentioned across multiple episodes | 1 show | Multiple shows |

## Cross-Platform Performance Analysis

### Unified Metrics

To compare across platforms, normalize to:

**Engagement Rate:**
```
Platform-adjusted Engagement Rate =
  (Total Engagements / Total Impressions) × Platform Adjustment Factor

Platform Adjustment Factors:
- X: 1.0x (baseline)
- Reddit: 1.5x (lower impression counts, higher quality signals)
- LinkedIn: 0.8x (inflated impression counts)
- YouTube: 1.2x (views are more intentional)
```

**Reach Score:**
```
Reach Score = Impressions × Platform Weight

Platform Weights (for B2B):
- LinkedIn: 1.5x (higher value per impression)
- YouTube: 1.3x (longer attention)
- X: 1.0x (baseline)
- Reddit: 0.8x (niche but valuable)
- Podcasts: 2.0x (highest attention quality)
```

### Performance Scoring Matrix

Rate each post on a 1-5 scale:

```
| Score | Label | Criteria |
|-------|-------|----------|
| 5 | Exceptional | Top 5% of your posts, viral potential |
| 4 | Strong | Above average engagement, positive sentiment |
| 3 | Average | Met typical engagement benchmarks |
| 2 | Below Average | Under-performed relative to your baseline |
| 1 | Poor | Significantly under-performed, consider why |
```

## Performance Report Template

```
## Content Performance Report — [Date Range]

### Overview
- Posts analyzed: [count]
- Platforms: [list]
- Average score: [X]/5
- Best platform: [platform] ([avg engagement rate])
- Best content type: [type] ([avg engagement rate])

### Top Performers
| Rank | Post | Platform | Score | Key Metric | Why It Worked |
|------|------|----------|-------|-----------|--------------|
| 1 | [summary] | [platform] | [score] | [metric] | [reason] |
| 2 | [summary] | [platform] | [score] | [metric] | [reason] |
| 3 | [summary] | [platform] | [score] | [metric] | [reason] |

### Under-Performers
| Post | Platform | Score | Key Metric | Why It Didn't Work | Fix |
|------|----------|-------|-----------|-------------------|-----|

### Performance by Category
| Category | Posts | Avg Score | Avg Engagement | Trend |
|----------|-------|-----------|----------------|-------|
| [Topic A] | [count] | [score] | [engagement] | ↑/↓/→ |

### Performance by Format
| Format | Posts | Avg Score | Avg Engagement | Trend |
|--------|-------|-----------|----------------|-------|
| [Format A] | [count] | [score] | [engagement] | ↑/↓/→ |

### Performance by Day/Time
| Day | Best Time | Avg Engagement | Posts |
|-----|-----------|----------------|-------|

### Key Patterns
1. [Pattern]: [evidence and recommendation]
2. [Pattern]: [evidence and recommendation]

### Next Period Recommendations
1. [Specific recommendation based on data]
2. [Specific recommendation based on data]
3. [Specific recommendation based on data]
```
