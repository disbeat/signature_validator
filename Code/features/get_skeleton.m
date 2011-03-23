function skeleton = get_skeleton(im)
	skeleton = int16(bwmorph(im,'skel',10));