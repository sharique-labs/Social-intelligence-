# Automation Patterns for Social Intelligence

## Overview

Social intelligence becomes most powerful when automated. Instead of manually checking social data, set up pipelines that continuously monitor, analyze, and report — so insights come to you.

## Pattern 1: Daily Morning Briefing

### Purpose
Start each day with a social intelligence summary.

### Setup
1. **Searches to create:**
   - Brand mentions (last 24 hours)
   - Competitor mentions (last 24 hours)
   - Industry keywords (last 24 hours)

2. **Schedule:** Daily at 7:00 AM (or preferred time)

3. **Output format:**
   ```
   ## Daily Social Briefing — [Date]

   ### Brand Pulse
   - Mentions: [count] (↑/↓ vs yesterday)
   - Sentiment: [positive/neutral/negative %]
   - Notable: [any high-engagement or concerning mentions]

   ### Competitor Activity
   - [Competitor A]: [key activity]
   - [Competitor B]: [key activity]

   ### Industry Trends
   - Trending topic: [topic] ([volume])
   - Emerging: [topic]

   ### Action Items
   1. [action]
   2. [action]
   ```

4. **Implementation:**
   - Use Trigify search with daily update frequency
   - Fetch results each morning
   - Run analysis frameworks from `analysis-frameworks.md`
   - Generate formatted briefing

## Pattern 2: Competitive Intelligence Radar

### Purpose
Continuous monitoring of competitive landscape with weekly reports.

### Setup
1. **Create searches for each competitor:**
   - [Competitor name] on each relevant platform
   - [Competitor product] mentions
   - [Competitor] + negative sentiment keywords
   - [Your brand] vs [competitor]

2. **Schedule:**
   - Search updates: Daily
   - Report generation: Weekly (Friday afternoon)

3. **Output format:**
   ```
   ## Weekly Competitive Report — Week of [Date]

   ### Share of Voice
   [Table comparing all competitors]

   ### Key Competitive Movements
   1. [Movement]: [Description and impact]
   2. [Movement]: [Description and impact]

   ### Content Strategy Shifts
   - [Competitor]: Started posting about [topic]
   - [Competitor]: Changed tone/format to [description]

   ### Opportunities for Us
   1. [Opportunity based on competitive gap]
   2. [Opportunity based on competitor weakness]

   ### Threats to Watch
   1. [Threat]: [Why and how to respond]
   ```

## Pattern 3: Content Performance Loop

### Purpose
Track your own content performance and iterate.

### Setup
1. **Track your posts:**
   - Brand name + own handle across platforms
   - Specific campaign hashtags
   - Product mention searches

2. **Schedule:**
   - Data collection: Daily
   - Performance review: Every Monday
   - Strategy adjustment: Monthly

3. **Workflow:**
   ```
   Post Content
       ↓
   Wait 48-72 hours
       ↓
   Fetch Performance Data
       ↓
   Analyze Against Benchmarks
       ↓
   Categorize: Hit / Miss / Neutral
       ↓
   Extract Patterns (what worked/didn't)
       ↓
   Update Content Strategy
       ↓
   Apply to Next Content
       ↓
   [Loop]
   ```

4. **Key metrics to automate:**
   - Engagement rate per post
   - Topic performance ranking
   - Format performance ranking
   - Optimal timing analysis
   - Audience sentiment on posts

## Pattern 4: Sales Signal Scanner

### Purpose
Automatically detect buying intent signals for sales team.

### Setup
1. **Create intent-based searches:**
   - "[category] recommendation" on Reddit
   - "looking for [solution type]" on X
   - "[competitor] alternative" on Reddit + X
   - "switching from [competitor]" across platforms
   - "[pain point keyword]" on Reddit + LinkedIn

2. **Schedule:** Daily updates (or more frequent for high-volume)

3. **Output format:**
   ```
   ## Sales Signals — [Date]

   ### High-Intent Leads
   | Signal | Platform | Post | Author | Intent Level |
   |--------|----------|------|--------|-------------|

   ### Competitor Dissatisfaction
   - [Post]: User complaining about [competitor feature]
   - [Post]: User asking for [competitor] alternative

   ### Category Interest
   - [Post]: User researching [your category]
   - [Post]: User asking for recommendations

   ### Suggested Actions
   1. Engage with [post] — user is actively looking
   2. Monitor [thread] — buying decision in progress
   ```

## Pattern 5: Crisis Detection System

### Purpose
Early warning system for brand reputation issues.

### Setup
1. **Create high-sensitivity searches:**
   - "[brand] terrible" OR "[brand] worst" OR "[brand] scam"
   - "[brand] down" OR "[brand] broken" OR "[brand] outage"
   - "[brand] lawsuit" OR "[brand] hack" OR "[brand] breach"

2. **Schedule:** Hourly or real-time (if supported)

3. **Alert thresholds:**
   - Normal: < 5 negative mentions per day
   - Elevated: 5-20 negative mentions per day
   - Crisis: > 20 negative mentions per day OR single post with >1000 engagements

4. **Response protocol:**
   - Elevated: Flag for marketing team review
   - Crisis: Immediate alert with post details, sentiment analysis, and recommended response

## Pattern 6: Product Feedback Pipeline

### Purpose
Continuously surface user feedback and feature requests.

### Setup
1. **Create product-specific searches:**
   - "[product] feature request" on Reddit + X
   - "[product] wish" OR "[product] should" on Reddit
   - "[product] bug" OR "[product] issue" on Reddit + X
   - "[product] love" OR "[product] hate" on Reddit + X

2. **Schedule:** Daily

3. **Output format:**
   ```
   ## Product Feedback Digest — [Date]

   ### Feature Requests (New)
   1. [Feature]: [Source post, engagement level]
   2. [Feature]: [Source post, engagement level]

   ### Bug Reports
   1. [Bug]: [Source post, severity indicator]

   ### User Satisfaction Signals
   - Positive: [count] mentions
   - Negative: [count] mentions
   - Key theme: [what users are praising/criticizing]

   ### Trending Request
   [Feature/improvement that's gaining traction]
   ```

## Implementation Notes

### Using Trigify's Update Frequency
- Set Trigify searches with appropriate update frequencies
- Fetch results at your desired reporting cadence
- Layer analysis on top of raw results

### Building Multi-Search Workflows
- Create a master list of all active searches
- Group searches by purpose (brand, competitor, industry, signals)
- Fetch all groups in sequence or parallel
- Aggregate results for cross-search analysis

### Scaling Considerations
- Start with 3-5 searches and expand
- Monitor search limits (check Trigify plan)
- Prioritize high-value searches
- Archive old searches that are no longer relevant

### Integration Points
- Feed results into content planning tools
- Connect to CRM for sales signals
- Export to dashboards for leadership visibility
- Trigger Slack/email alerts for urgent items
