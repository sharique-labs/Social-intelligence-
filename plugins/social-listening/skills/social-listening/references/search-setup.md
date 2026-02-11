# Social Listening Search Setup Guide

## Search Types

### 1. Keyword Search
Monitor specific keywords or phrases across platforms.

**When to use:** Tracking topics, industry terms, product categories, or specific conversations.

**Setup pattern:**
- Primary keyword(s): The main terms to track
- Supporting keywords: Additional context terms (use AND to require them)
- Exclusion keywords: Terms to filter out noise (use NOT)
- Platform: Which social platform(s) to search
- Timeframe: How far back to look (default: 7 days)
- Update frequency: How often to refresh (default: daily)

**Example:**
```
Keywords: "claude code" AND ("skills" OR "plugins" OR "marketing")
Platform: X (Twitter)
Lookback: 7 days
Frequency: Daily
```

### 2. Competitor Search
Monitor specific companies, brands, or individuals.

**When to use:** Tracking what competitors post, what people say about them, or competitive comparisons.

**Setup pattern:**
- Competitor name(s): Brand names to track
- Product names: Specific products to monitor
- Competitor handles: Social media handles for direct tracking
- Comparison terms: "[competitor] vs", "[competitor] alternative"
- Platform: Target platforms where competitors are active

**Example:**
```
Search 1: "CompetitorCo" on X + Reddit + LinkedIn
Search 2: "CompetitorCo" AND ("review" OR "experience" OR "alternative")
Search 3: "YourBrand vs CompetitorCo"
```

### 3. Brand Search
Monitor your own brand mentions and perception.

**When to use:** Tracking brand health, customer feedback, and public perception.

**Setup pattern:**
- Brand name and variations
- Product names
- Key people (founder, CEO)
- Branded hashtags
- Sentiment-specific searches (love/hate + brand)

### 4. Industry Search
Monitor industry-wide conversations and trends.

**When to use:** Staying ahead of market trends, identifying emerging topics, spotting opportunities.

**Setup pattern:**
- Industry category terms
- Trending topic keywords
- Problem/solution phrases ("how to [industry task]")
- Technology or methodology terms

### 5. Signal Search (Sales-focused)
Monitor for buying intent and prospect activity.

**When to use:** Finding leads, detecting buying signals, identifying prospects in-market.

**Setup pattern:**
- Buying intent phrases: "looking for", "recommend", "alternative to", "switching from"
- Problem statements: "[pain point]", "struggling with", "need help with"
- Category + platform targeting (Reddit r/subreddits, LinkedIn industry groups)

## Boolean Search Operators

Use these to build precise searches:

| Operator | Usage | Example |
|----------|-------|---------|
| AND | All terms must be present | "claude code" AND "marketing" |
| OR | Any term can be present | "plugin" OR "skill" OR "extension" |
| NOT | Exclude term | "AI" NOT "artificial" |
| " " | Exact phrase | "social listening" |
| ( ) | Group operators | ("plugin" OR "skill") AND "claude" |

## Platform-Specific Search Tips

### X (Twitter)
- High volume, real-time conversations
- Good for: Breaking news, industry reactions, quick takes
- Tip: Use specific phrases to cut through noise

### Reddit
- Community-driven discussions, longer form
- Good for: Honest product reviews, detailed comparisons, support issues
- Tip: Subreddit context matters — track platform-specific subreddits

### YouTube
- Video content, tutorials, reviews
- Good for: Product demos, competitor content strategy, educational content
- Tip: Video titles and descriptions are searchable

### LinkedIn
- Professional conversations, B2B focus
- Good for: Thought leadership, business announcements, industry trends
- Tip: Company page activity + employee posts give full picture

### Podcasts
- Long-form discussions, interviews
- Good for: Industry insights, thought leadership, in-depth analysis
- Tip: Guest appearances and topic mentions signal industry relevance

## Timeframe Guidelines

| Use Case | Recommended Lookback | Update Frequency |
|----------|---------------------|------------------|
| Breaking news monitoring | 24 hours | Hourly |
| Competitor daily tracking | 7 days | Daily |
| Content strategy research | 30 days | Weekly |
| Industry trend analysis | 90 days | Weekly |
| Brand audit | 90 days | One-time |
| Campaign tracking | Campaign duration | Daily |

## Multi-Search Strategies

### The Competitive Radar (5 searches)
1. Your brand mentions
2. Competitor A mentions
3. Competitor B mentions
4. Industry keyword tracking
5. "[Your brand] vs [competitor]" comparisons

### The Content Engine (4 searches)
1. Industry trending topics
2. Questions being asked in your space
3. Competitor content that's performing well
4. Your own content performance

### The Sales Signal Scanner (3 searches)
1. Buying intent keywords in your category
2. Competitor complaints and dissatisfaction
3. Problem statements matching your solution
