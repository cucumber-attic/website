require 'cucumber/website/ul_builder'

module Cucumber::Website
  describe UlBuilder do
    it "builds a flat list" do
      b = UlBuilder.new([
        {href: '#a', text: 'A'},
        {href: '#b', text: 'B'},
        {href: '#c', text: 'C'}
      ])
      expect(b.build).to eq(<<-HTML)
<ul>
  <li><a href="#a">A</a>
  </li>
  <li><a href="#b">B</a>
  </li>
  <li><a href="#c">C</a>
  </li>
</ul>
HTML
    end

    it "nests one at deeper level" do
      b = UlBuilder.new([
        {href: '#a', text: 'A'},
        [
          {href: '#b', text: 'B'}
        ]
      ])
      expect(b.build).to eq(<<-HTML)
<ul>
  <li><a href="#a">A</a>
  <ul>
    <li><a href="#b">B</a>
    </li>
  </ul>
  </li>
</ul>
HTML
    end

    it "works with a complex tree" do
      b = UlBuilder.new([
        {href: '#a', text: 'A'},
        [
          {href: '#b', text: 'B'},
          [
            {href: '#c', text: 'C'}
          ],
          {href: '#d', text: 'D'},
        ],
        {href: '#e', text: 'E'},
      ])
      expect(b.build).to eq(<<-HTML)
<ul>
  <li><a href="#a">A</a>
  <ul>
    <li><a href="#b">B</a>
    <ul>
      <li><a href="#c">C</a>
      </li>
    </ul>
    </li>
    <li><a href="#d">D</a>
    </li>
  </ul>
  </li>
  <li><a href="#e">E</a>
  </li>
</ul>
HTML
    end
  end
end
