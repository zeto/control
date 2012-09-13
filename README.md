Workflow engine

[![Build Status](https://secure.travis-ci.org/zeto/control.png)](http://travis-ci.org/zeto/control)

Premises
<ul>
<li>ActiveRecord</li>
<li>Each state is a separate object.</li>
</ul>

Features
<ul>
<li>State can be as rich in functionality was wanted.</li>
<li>No data is ever lost. History is always saved. </li>
<li>It is possible to track every single transition done in the workflow.</li>
<li>Advancing a state is as easy as creating a state object and calling "save".</li>
<li>Can transition to same state.</li>
<li>Minimal code to define workflow and states.</li>
</ul>

Simple example for a Bulb with two states:

<pre><code>
class Bulb < ActiveRecord::Base
  include Control::Workflow
  
  has_many :ons
  has_many :offs
end

class On < ActiveRecord::Base
  include Control::State
	
  belongs_to :bulb
end

class Off < ActiveRecord::Base
  include Control::State

  belongs_to :bulb
  next_states :on # optional, to constrain possible next states, can also specify :none to make a state final
end

def example
  my_bulb = Bulb.new
  
  my_on = On.new do |o|
    o.bulb = my_bulb
  end
  
  my_off = Off.new do |o|
    o.bulb = my_bulb
  end
  
  # Check possible states for my bulb. (On, Off)
  my_bulb.states
  
  # Transitions the bulb to the "On" state
  my_on.save
  
  # Transitions the bulb to the "Off" state
  my_off.save
  
  # Every transition is recorded. (On -> Off)
  my_bulb.transitions
  
  # Bulb knows which state is current. (Off)
  my_bulb.current_state
end
</code></pre>

Installing:

1. Add control gem to gemfile.
<pre><code>gem 'control'</code></pre>
or
<pre><code>gem 'control', :git => 'git://github.com/zeto/control.git' # Edge</code></pre>

2. Generate tables (run rake db:migrate after)
<pre><code>$ rails generate control_install</pre></code>

Testing the gem:
<pre><code>
$ bundle
$ rake
</pre></code>

