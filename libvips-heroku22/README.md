# demo a crash with the pdfium binaries

```
docker pull heroku/heroku:22
docker build -t libvips-heroku22 .
```

The build ends with a crash:

```
 => ERROR [22/22] RUN cd x   && echo 'require "vips"; Vips::Image.new_fro  3.6s
------                                                                          
 > [22/22] RUN cd x   && echo 'require "vips"; Vips::Image.new_from_file("../demo.heic")' |      DISABLE_SPRING=1 bundle exec bin/rails c:                      
2.754 Loading development environment (Rails 6.1.4.1)                           
2.754 Switch to inspect mode.                                                   
2.755 require "vips"; Vips::Image.new_from_file("../demo.heic")                 
2.759 /var/lib/gems/3.0.0/gems/ruby-vips-2.1.4/lib/vips/operation.rb:225: [BUG] Segmentation fault at 0x000000000000001d
2.759 ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux-gnu]
2.759 
2.759 -- Control frame information -----------------------------------------------
2.759 c:0052 p:---- s:0324 e:000323 CFUNC  :vips_cache_operation_build
2.759 c:0051 p:0012 s:0319 e:000318 METHOD /var/lib/gems/3.0.0/gems/ruby-vips-2.1.4/lib/vips/operation.rb:225
```

If I run in gdb, I see:

```
Thread 1 "ruby" hit Breakpoint 2, vips_foreign_load_heif_build (object=0x556f1aa49120) at ../libvips/foreign/heifload.c:248
248	{
(gdb) n
249		VipsForeignLoadHeif *heif = (VipsForeignLoadHeif *) object;
(gdb) 
255		if( heif->source &&
(gdb) 
256			vips_source_rewind( heif->source ) )
(gdb) 
255		if( heif->source &&
(gdb) 
259		if( !heif->ctx ) {
(gdb) 
262			heif->ctx = heif_context_alloc();
(gdb) 
265				heif->unlimited ? USHRT_MAX : 0x4000 );
(gdb) 
264			heif_context_set_maximum_image_size_limit( heif->ctx,
(gdb) 
268				heif->reader, heif, NULL );
(gdb) 
267			error = heif_context_read_from_reader( heif->ctx, 
(gdb) 

Thread 1 "ruby" received signal SIGSEGV, Segmentation fault.
0x00007f79c35592b7 in allocator_shim::internal::PartitionFree(allocator_shim
::AllocatorDispatch const*, void*, void*) () from /usr/local/lib/libpdfium.so
```

So `heif_context_read_from_reader()`, part of the libheif API, is unexpectedly
calling `allocator_shim::internal::PartitionFree()` in `libpdfium.so` and
crashing.
