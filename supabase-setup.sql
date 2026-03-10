-- Run this in your Supabase SQL Editor
-- Go to: supabase.com → your project → SQL Editor → New query → paste this → Run

create table if not exists prompts (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  prompt text not null,
  image_url text,
  category text not null default 'General',
  tier text not null default 'free' check (tier in ('free','starter','pro','unlimited')),
  model text default 'General',
  tags text[],
  active boolean default true,
  created_at timestamp with time zone default now()
);

-- Allow public read (library page reads prompts)
alter table prompts enable row level security;

create policy "Public can read active prompts"
  on prompts for select
  using (active = true);

create policy "Admin can do everything"
  on prompts for all
  using (true)
  with check (true);

-- Add some sample prompts so the library isn't empty on launch
insert into prompts (title, prompt, image_url, category, tier, model) values
(
  'Golden Hour Editorial',
  'A woman in a flowing silk dress standing on a rooftop at golden hour, editorial fashion photography, film grain, warm amber light, shadows long and soft, Vogue aesthetic, 35mm lens',
  'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=600&q=80',
  'Editorial',
  'free',
  'Midjourney'
),
(
  'Cinematic Desert Drive',
  'A vintage red convertible driving through a vast empty desert highway at dusk, cinematic wide shot, dust trails, warm orange sky, film look, Wim Wenders inspired',
  'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&q=80',
  'Cinematic',
  'free',
  'Kling.3'
),
(
  'Luxury Product Float',
  'A perfume bottle floating mid-air against a deep black background, dramatic studio lighting, crystal reflections, luxury editorial, ultra sharp, commercial photography style',
  'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=600&q=80',
  'Product',
  'starter',
  'Midjourney'
),
(
  'Neon City Rain',
  'A rainy Tokyo street at night, reflections of neon signs in puddles, lone figure with umbrella, cyberpunk aesthetic, deep blues and pinks, cinematic grain, Blade Runner mood',
  'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=600&q=80',
  'Cinematic',
  'free',
  'Kling.3'
),
(
  'Abstract Fluid Forms',
  'Macro shot of metallic liquid mercury forming abstract organic shapes, silver and gold tones, extreme detail, studio light, luxury art print, minimal background',
  'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&q=80',
  'Abstract',
  'pro',
  'Midjourney'
),
(
  'Forest Morning Light',
  'Ancient forest at dawn, shafts of golden light through tall trees, mist rising from the ground, photorealistic, National Geographic style, Canon 5D, f/2.8',
  'https://images.unsplash.com/photo-1448375240586-882707db888b?w=600&q=80',
  'Nature',
  'free',
  'General'
);
